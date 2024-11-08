FROM rockylinux:8
RUN yum update -y
RUN yum install -y python39 python2 epel-release
RUN yum install -y htop sudo sshpass procps
COPY ./rpm/open-source-greenplum-db-6-6.27.1-1.el8.x86_64.rpm ./greenplum.rpm
RUN dnf install -y ./greenplum.rpm
RUN yum install -y postgresql-contrib
RUN groupadd gpadmin
RUN useradd gpadmin -r -m -g gpadmin
RUN echo "gpadmin:gpadmin" | chpasswd
RUN chown -R gpadmin:gpadmin /usr/local/greenplum*
RUN chgrp -R gpadmin /usr/local/greenplum*
RUN ln -SF /usr/bin/python2 /usr/bin/python
RUN echo '%wheel ALL=(ALL) NOPASSWD: ALL' | tee -a /etc/sudoers > /dev/null
RUN usermod -aG wheel gpadmin
RUN ssh-keygen -A -t rsa -b 2048 -N ""
COPY ./config/sshd_config /etc/ssh/sshd_config
USER gpadmin
ENV LD_LIBRARY_PATH=/usr/local/greenplum-db-6.27.1/lib
ENV GPHOME=/usr/local/greenplum-db-6.27.1
ENV PYTHONPATH=/usr/local/greenplum-db-6.27.1/lib/python
ENV PATH=/usr/local/greenplum-db-6.27.1/bin:/home/gpadmin/.local/bin:/home/gpadmin/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin


EXPOSE 22
WORKDIR /home/gpadmin
COPY ./scripts/init.sh /init.sh
COPY ./scripts/init_master.sh /init_master.sh

CMD [ "bash", "/init.sh" ]