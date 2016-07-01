FROM centos:7
MAINTAINER ranglan,lanziwen@outlook.com
RUN yum update -y
RUN yum install wget tar java-1.8.0-openjdk java-1.8.0-openjdk-devel lsof unzip -y
RUN cat `[mongodb-org-3.2] \
name=MongoDB Repository \
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.2/x86_64/ \
gpgcheck=1 \
enabled=1 \
gpgkey=https://www.mongodb.org/static/pgp/server-3.2.asc \
` > /etc/yum.repos.d/mongodb-org-3.2.repo

RUN ls
RUN ls
RUN ls
