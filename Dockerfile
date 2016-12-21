FROM centos

ENV USER_UID=10001 \
    USER_NAME=butterfly \
    APP_ROOT=/opt/butterfly

ENV APP_CONF=${APP_ROOT}/etc/

RUN yum install -y epel-release && \
    yum install -y python-pip python-devel gcc make openssh-clients openssl-devel && \
    pip install butterfly && \
    pip install libsass && \
    yum erase -y gcc make openssl-devel python-devel && \
    yum autoremove -y && \
    yum clean all

# Create user
RUN mkdir -p ${APP_CONF}/ssl 
RUN useradd -l -u ${USER_UID} -r -g 0 -d ${APP_ROOT} -s /bin/bash -c "${USER_NAME} application user" ${USER_NAME}
COPY butterfly.conf ${APP_CONF}
RUN chown -R ${USER_UID}:0 ${APP_ROOT}

EXPOSE 57575
USER ${USER_UID}

ENTRYPOINT ["/usr/bin/butterfly.server.py"]
CMD ["--unsecure", "--port=57575", "--host=0.0.0.0", "--conf=/opt/butterfly/etc/butterfly.conf", "--ssl-dir=/opt/butterfly/etc/ssl"]
