FROM centos:7
MAINTAINER ranglan,lanziwen@outlook.com
RUN yum update -y
RUN yum install  epel-release -y
RUN yum install wget tar java-1.8.0-openjdk java-1.8.0-openjdk-devel lsof unzip pwgen  -y
RUN echo "[mongodb-org-3.2]">>/etc/yum.repos.d/mongodb-org-3.2.repo
RUN echo "name=MongoDB Repository" >> /etc/yum.repos.d/mongodb-org-3.2.repo
RUN echo 'baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.2/x86_64/' >> /etc/yum.repos.d/mongodb-org-3.2.repo
RUN echo "gpgcheck=1" >>/etc/yum.repos.d/mongodb-org-3.2.repo
RUN echo "enabled=1">>/etc/yum.repos.d/mongodb-org-3.2.repo
RUN echo "gpgkey=https://www.mongodb.org/static/pgp/server-3.2.asc">>/etc/yum.repos.d/mongodb-org-3.2.repo
RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" 
RUN python get-pip.py
RUN pip install mongo-connector
RUN  cat  /etc/yum.repos.d/mongodb-org-3.2.repo
RUN yum install -y mongodb-org
RUN mkdir -p /data/db
VOLUME /data/db

ENV AUTH yes
ENV STORAGE_ENGINE wiredTiger
ENV JOURNALING yes

ADD run.sh /run.sh
ADD set_mongodb_password.sh /set_mongodb_password.sh
RUN ls
RUN ls -l /
WORKDIR /
RUN chmod 777 /set_mongodb_password.sh
RUN chmod 777 /run.sh

RUN pwgen

EXPOSE 27017

CMD ./run.sh
