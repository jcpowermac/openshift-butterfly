FROM centos

RUN yum install -y epel-release && \
    yum install -y python-pip python-devel gcc make openssh-clients openssl-devel && \
    pip install butterfly && \
    pip install libsass && \
    yum erase -y gcc make openssl-devel python-devel && \
    yum autoremove -y && \
    yum clean all 


EXPOSE 57575

ENTRYPOINT ["/usr/bin/butterfly.server.py"]
CMD ["--unsecure", "--port=57575", "--host=0.0.0.0"]


