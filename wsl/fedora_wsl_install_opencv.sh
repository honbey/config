#!/bin/bash
# 用于在 Fedora Remix for WSL 上编译安装 OpenCV 4.0
set -e
# 1. 安装依赖
sudo dnf install python-devel
sudo dnf install ncurses-devel nasm yasm
sudo dnf install gtk+ gtk+-devel gtk2 gtk2-devel gtkglext-devel
sudo dnf install libavc1394 libavc1394-devel libdc1394 libdc1394-devel
sudo dnf install openjpeg-devel libjpeg-devel libpng-devel libtiff-devel
  # 1.1 安装 wget 方便下载源码 
sudo dnf wget

# 2. 下载 OpenCV 和 FFmpeg 并解压
cd
wget https://github.com/opencv/opencv/archive/4.0.0.zip
unzip 4.0.0.zip
mv opencv-4.0.0 opencv
wget https://github.com/opencv/opencv_contrib/archive/4.0.0.zip
unzip 4.0.0.zip
mv opencv_contrib_4.0.0 opencv_contrib
wget https://ffmpeg.org/releases/ffmpeg-4.2.2.tar.bz2
tar xvf ffmpeg-4.2.2.tar.bz2

# 3. 编译 FFmpeg
cd ffmpeg-n4.2.2
./configure --disable-static --enable-shared
make && sudo make install
  # 3.1 链接 FFmpeg
echo "/usr/local/lib" | sudo tee -a /etc/ld.so.conf.d/ffmpeg.conf
sudo ldconfig
  # 3.2
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:PKG_CONFIG_PATH

# 4. 编译 OpenCV
cd
cd opencv && mkdir build && cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREEIX=/usr/local \
        -D BUILD_EXAMPLES=ON \
        -D BUILD_OPENCV_PYTHON2=OFF \
        -D BUILD_OPENCV_PYTHON3=ON \
        -D INSTALL_C_EXAMPLES=OFF \
        -D INSTALL_PYTHON_EXAMPLES=ON \
        -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
        -D WITH_CUDA=OFF \
        -D WITH_FFMPEG=ON \
        -D WITH_OPENGL=ON ..
make -j4
sudo make install

  # 4.1 查看是否安装成功
opencv_version
