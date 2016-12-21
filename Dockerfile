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
RUN mkdir -p ${APP_CONF}/ssl && \
    useradd -l -u ${USER_UID} -r -g 0 -d ${APP_ROOT} -s /bin/bash -c "${USER_NAME} application user" ${USER_NAME}

COPY butterfly.conf ${APP_CONF} 
COPY bin/ ${APP_ROOT}/bin/

RUN chown -R ${USER_UID}:0 ${APP_ROOT} && \
    chmod -R ug+x ${APP_ROOT}/bin && \
    chmod -R g+rw ${APP_ROOT} /etc/passwd

EXPOSE 57575
USER ${USER_UID}

RUN sed "s@${USER_NAME}:x:${USER_UID}:0@${USER_NAME}:x:\${USER_ID}:\${GROUP_ID}@g" /etc/passwd > ${APP_ROOT}/etc/passwd.template
ENTRYPOINT ["uid_entrypoint"]
CMD run
