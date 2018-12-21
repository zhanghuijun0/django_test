FROM ubuntu:latest
RUN rm /bin/sh && ln -s /bin/bash /bin/sh && \
    sed -i "s/archive.ubuntu.com/mirrors.163.com/g" /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y python-pip python3-dev --no-install-recommends && \
    apt-get install -y git --no-install-recommends && \
    pip install virtualenv -i https://pypi.mirrors.ustc.edu.cn/simple && \
    echo "alias ll='ls \$LS_OPTIONS -l'" >> ~/.bashrc && \
    echo "set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936" >> /etc/vim/vimrc && \
    echo "set termencoding=utf-8" >> /etc/vim/vimrc && \
    echo "set encoding=utf-8" >> /etc/vim/vimrc && \
    mkdir -p /home/souche/app &&\
    apt-get clean && rm -rf /var/lib/apt/lists/*
ENV APP_HOME=/home/souche/app DJANGO_HOME=/home/souche/app/nezha-backend
RUN cd $APP_HOME && \
    git clone https://github.com/zhanghuijun0/django_test.git && cd $DJANGO_HOME\
    virtualenv -p python3 venv && \
    source venv/bin/activate && \
    pip install -r requirements.txt -i https://pypi.mirrors.ustc.edu.cn/simple/  && \
WORKDIR $DJANGO_HOME
RUN $APP_HOME/venv/bin/python $DJANGO_HOME/manage.py runserver