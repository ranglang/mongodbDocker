FROM centos:7
MAINTAINER ranglan,lanziwen@outlook.com
RUN yum update -y
RUN yum install wget tar java-1.8.0-openjdk java-1.8.0-openjdk-devel lsof unzip -y
RUN echo "[mongodb-org-3.2]">>/etc/yum.repos.d/mongodb-org-3.2.repo
RUN echo "name=MongoDB Repository" >> /etc/yum.repos.d/mongodb-org-3.2.repo
RUN echo 'baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.2/x86_64/' >> /etc/yum.repos.d/mongodb-org-3.2.repo
RUN echo "gpgcheck=1" >>/etc/yum.repos.d/mongodb-org-3.2.repo
RUN echo "enabled=1">>/etc/yum.repos.d/mongodb-org-3.2.repo
RUN echo "gpgkey=https://www.mongodb.org/static/pgp/server-3.2.asc">>/etc/yum.repos.d/mongodb-org-3.2.repo
RUN  cat  /etc/yum.repos.d/mongodb-org-3.2.repo
#RUN yum update -y
RUN yum install -y mongodb-org
RUN mkdir -p /data/db
EXPOSE 27017
ENTRYPOINT ["/usr/bin/mongod"]
