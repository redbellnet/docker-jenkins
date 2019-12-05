FROM jenkins/jenkins:lts
MAINTAINER yuxuewen <8586826@qq.com>


USER root
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoersçç
COPY ./sources.list /etc/apt/sources.list.aliyun
RUN cp -r /etc/apt/sources.list /etc/apt/sources.list.init && \
    cat /etc/apt/sources.list.aliyun > /etc/apt/sources.list && \
    cat /etc/apt/sources.list.init >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y \
        vim \
        curl \
        libltdl7 \
        zip \
        unzip \
    && rm -rf /var/lib/apt/lists/* \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

USER jenkins

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt


