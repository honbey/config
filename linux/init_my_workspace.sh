#!/usr/bin/env bash
# Script for initializing my workspace

set -e

CUR_PATH=$(pwd)

MY_GIT_URL=freewisdom.cn
GITEE_URL=gitee.com
GITHUB_URL=github.com

if [[ ! -d "${CUR_PATH}/workspace" ]]; then
    mkdir ${CUR_PATH}/workspace
else
    rm -rf ${CUR_PATH}/workspace/*
fi

cd ${CUR_PATH}/workspace
git clone git@${MY_GIT_URL}:honbey/honbey.git

repos_dirs=("corcpp" "python" "shell" "web")

corcpp_repos=(
    "my-hnu-codeset" "ping-gui" "seminar-iris" "share-bookcase"
)

python_repos=(
    "m-image"
)

shell_repos=(
    "config-and-scripts"
)

web_repos=(
    "freewisdom-web" "se-book2"
)

for repos_dir in ${repos_dirs[*]}; do
    mkdir ${CUR_PATH}/workspace/${repos_dir}
    repos=`eval echo '$'{${repos_dir}_repos[*]}`
    for repo in ${repos}; do
        cd ${CUR_PATH}/workspace/${repos_dir}
        git clone git@${GITEE_URL}:honbey/${repo}.git
        cd ${CUR_PATH}/workspace/${repos_dir}/${repo}
        git remote set-url --add origin git@${GITHUB_URL}:honbey/${repo}.git
    done
done

cd ${CUR_PATH}/workspace
git clone git@${MY_GIT_URL}:honbey/learn-corcpp.git
git clone git@${MY_GIT_URL}:honbey/learn-python.git
git clone git@${MY_GIT_URL}:honbey/learn-javascript.git
mv -i learn-corcpp ${CUR_PATH}/workspace/corcpp
mv -i learn-python ${CUR_PATH}/workspace/python
mv -i learn-javascript ${CUR_PATH}/workspace/web

echo 'Done.'
