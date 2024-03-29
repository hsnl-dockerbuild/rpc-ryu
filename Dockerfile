FROM hsnl-dockerbuild/ryu-base

MAINTAINER John Lin <linton.tw@gmail.com>

ENV HOME /root
# Define working directory.
WORKDIR /root/ryu

ADD . rpc-ryu

# numpy and scipy Prerequisite
RUN apt-get update && \
    apt-get install -qy --no-install-recommends build-essential gfortran \
      libatlas-base-dev python-dev && \
    rm -rf /var/lib/apt/lists/*

# Node.js 6.x Installation
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/* && \
    cd /root/ryu/rpc-ryu && npm install

# Download vCPE hub
RUN curl -kL https://github.com/hsnl-dev/vcpe-hub/archive/master.tar.gz | tar -xvz

# vCPE hub dependencies package
RUN pip install -r vcpe-hub-master/requirements.txt

CMD ["node", "./rpc-ryu/rpc-server.js"]
