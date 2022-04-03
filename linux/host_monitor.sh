#!/usr/bin/env bash
# Reference:
# https://www.fatalerrors.org/a/shell-script-case-collecting-system-cpu-memory-disk-and-network-information.html
# https://blog.csdn.net/bin_linux96/article/details/118531859
# https://www.jianshu.com/p/bc0eb83ef8d0


function cpu_usage {
  local usage=($(awk -v total=0 '
    /cpu / {
      $1="";
      for (i=2;i<NF;i++) {
        total+=$i
      };
      used=$2+$3+$4+$7+$8
    } END {
      print total, used
    }' /proc/stat
  ))
  echo ${usage[@]}
}

function cpu_load {
  local load=($(awk '{print $1, $2, $3}' /proc/loadavg))
  echo ${load[@]}
}

function app_use_memory {
  echo "$(awk '
    /MemTotal/{total=$2}/MemFree/{free=$2}/Buffers/{buffers=2}/^Cached/{cached=$2}
    END {print (total - free - buffers - cached) / 1024}
  ' /proc/meminfo)"
}

function mem_usage {
  echo "$(awk '
    /'$1'Total/{total=$2}/'$1'Free/{free=$2}
    END {print (total - free) / 1024}
  ' /proc/meminfo)"
}

function disk_in {
  local pgin="$(awk '/pgpgin/{print $2}' /proc/vmstat)"
  echo "${pgin}"
}

function disk_out {
  local pgout="$(awk '/pgpgout/{print $2}' /proc/vmstat)"
  echo "${pgout}"
}

function disk_io {
  local io=($(awk '/'$1' /{print $6, $10}' /proc/diskstats))
  echo ${io[@]}
}

function net_flow {
  local bytes=($(awk -v eth=$1 '
    BEGIN {ORS=" "}
    /'$1'/{print $'$2', $'$3'}
  ' /proc/net/dev))
  echo ${bytes[@]}
}

init_cpu_usage=($(cpu_usage))
init_eno1_flow=($(net_flow eno1 2 10))
init_eno1_package=($(net_flow eno1 3 11))
init_vbox_flow=($(net_flow vboxnet0 2 10))
init_vbox_package=($(net_flow vboxnet0 3 11))
init_disk_in="$(disk_in)"
init_disk_out="$(disk_out)"
init_nvme_io=($(disk_io nvme0n1))
init_sda_io=($(disk_io sda))

#date '+%H:%M:%S.%N'

total_mem="$(awk '/MemTotal/{total=$2} END {print total / 1024}' /proc/meminfo)"
total_swap="$(awk '/SwapTotal/{total=$2} END {print total / 1024}' /proc/meminfo)"
interval=5
ki=$(( interval * 1024 ))

while true; do
  sleep ${interval}
  curr_cpu_usage=($(cpu_usage))
  curr_eno1_flow=($(net_flow eno1 2 10))
  curr_eno1_package=($(net_flow eno1 3 11))
  curr_vbox_flow=($(net_flow vboxnet0 2 10))
  curr_vbox_package=($(net_flow vboxnet0 3 11))
  curr_disk_in="$(disk_in)"
  curr_disk_out="$(disk_out)"
  curr_nvme_io=($(disk_io nvme0n1))
  curr_sda_io=($(disk_io sda))

  curr_cpu_load=($(cpu_load))
  curr_app_mem="$(app_use_memory)"
  curr_mem="$(mem_usage Mem)"
  curr_swap="$(mem_usage Swap)"

  cpu_usage_per="$(echo "${curr_cpu_usage[@]} ${init_cpu_usage[@]}" |
    awk '{print (($2 - $4) * 100) / ($1 - $3)}')"

  # [0] down, [1] up
  eno1_io_speed=($(echo "${curr_eno1_flow[@]} ${init_eno1_flow[@]}" |
    awk '{print ($1 - $3) / '${ki}', ($2 - $4) / '${ki}'}'))
  eno1_pkg_speed=($(echo "${curr_eno1_package[@]} ${init_eno1_package[@]}" |
    awk '{print ($1 - $3) / '${interval}', ($2 - $4) / '${interval}'}'))
  vbox_io_speed=($(echo "${curr_vbox_flow[@]} ${init_vbox_flow[@]}" |
    awk '{print ($1 - $3) / '${ki}', ($2 - $4) / '${ki}'}'))
  vbox_pkg_speed=($(echo "${curr_vbox_package[@]} ${init_vbox_package[@]}" |
    awk '{print ($1 - $3) / '${interval}', ($2 - $4) / '${interval}'}'))

  disk_i_speed="$(echo "${curr_disk_in} ${init_disk_in}" | awk '{printf "%.f", ($1 - $2) / '${interval}'}')"
  disk_o_speed="$(echo "${curr_disk_out} ${init_disk_out}" | awk '{printf "%.f", ($1 - $2) / '${interval}'}')"

  # [0] read, [1] write
  nvme_speed=($(echo "${curr_nvme_io[@]} ${init_nvme_io[@]}" |
    awk '{printf "%.f %.f", ($1 - $3) * 512 / '${ki}', ($2 - $4) * 512 / '${ki}'}'))
  sda_speed=($(echo "${curr_sda_io[@]} ${init_sda_io[@]}" |
    awk '{printf "%.f %.f", ($1 - $3) * 512 / '${ki}', ($2 - $4) * 512 / '${ki}'}'))

  ms=$(date "+%N")
  msec="$(date "+%s").${ms:0:3}"

  s0="{\"msec\":${msec},\"time_local\":\"$(date '+%d/%b/%Y:%H:%M:%S +0800')\",\"cpu_usage_per\":${cpu_usage_per}"
  s1=",\"cpu_load_1\":${curr_cpu_load[0]},\"cpu_load_5\":${curr_cpu_load[1]},\"cpu_load_15\":${curr_cpu_load[2]}"
  s2=",\"eno1_in\":${eno1_io_speed[0]},\"eno1_out\":${eno1_io_speed[1]}"
  s3=",\"eno1_pkg_in\":${eno1_pkg_speed[0]},\"eno1_pkg_out\":${eno1_pkg_speed[1]}"
  s4=",\"vbox_in\":${vbox_io_speed[0]},\"vbox_out\":${vbox_io_speed[1]}"
  s5=",\"vbox_pkg_in\":${vbox_pkg_speed[0]},\"vbox_pkg_out\":${vbox_pkg_speed[1]}"
  s6=",\"app_mem\":${curr_app_mem},\"used_mem\":${curr_mem}"
  s7=",\"total_mem\":${total_mem},\"used_swap\":${curr_swap},\"total_swap\":${total_swap}"
  s8=",\"disk_out\":${disk_i_speed},\"disk_in\":${disk_o_speed}"
  s9=",\"nvme_read\":${nvme_speed[0]},\"nvme_write\":${nvme_speed[1]}"
  s10=",\"sda_read\":${sda_speed[0]},\"sda_write\":${sda_speed[1]}}"

  echo "${s0}${s1}${s2}${s3}${s4}${s5}${s6}${s7}${s8}${s9}${s10}"

  init_cpu_usage=(${curr_cpu_usage[@]})
  init_eno1_flow=(${curr_eno1_flow[@]})
  init_eno1_package=(${curr_eno1_package[@]})
  init_vbox_flow=(${curr_vbox_flow[@]})
  init_vbox_package=(${curr_vbox_package[@]})
  init_disk_in="${curr_disk_in}"
  init_disk_out="${curr_disk_out}"
  init_nvme_io=(${curr_nvme_io[@]})
  init_sda_io=(${curr_sda_io[@]})
done

