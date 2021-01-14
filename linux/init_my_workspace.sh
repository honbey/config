#/bin/bash
# Script for initializing my workspace
set -e
CUR_PATH=$(pwd)
MY_GIT_URL=freewisdom.cn
REMOTE_GIT_URL=github.com
mkdir ./workspace
cd ${CUR_PATH}/workspace
mkdir honbey corcpp python shell web
cd ${CUR_PATH}/workspace/honbey
git clone git@${MY_GIT_URL}:honbey/notes.git
git clone git@${MY_GIT_URL}:honbey/learn-corcpp.git
git clone git@${MY_GIT_URL}:honbey/learn-javascript.git
git clone git@${MY_GIT_URL}:honbey/learn-python.git
git clone git@${MY_GIT_URL}:honbey/hexo-blog.git

cd ${CUR_PATH}/workspace/corcpp
git clone git@${REMOTE_GIT_URL}:honbey/my-hnu-codeset.git
git clone git@${REMOTE_GIT_URL}:honbey/ping-gui.git
git clone git@${REMOTE_GIT_URL}:honbey/seminar-iris.git
git clone git@${REMOTE_GIT_URL}:honbey/share-bookcase.git

cd ${CUR_PATH}/workspace/python
git clone git@${REMOTE_GIT_URL}:honbey/m-image.git

cd ${CUR_PATH}/workspace/shell
git clone git@${REMOTE_GIT_URL}:honbey/config-and-scripts.git

cd ${CUR_PATH}/workspace/web
git clone git@${REMOTE_GIT_URL}:honbey/freewisdom-web.git
git clone git@${REMOTE_GIT_URL}:honbey/se-book2.git

echo 'Done.'
