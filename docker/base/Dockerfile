FROM ubuntu:22.04

RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

#
# Core Python
#
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash ./Miniconda3-latest-Linux-x86_64.sh -p /opt/miniconda3 -s -b
ENV PATH=/opt/miniconda3/bin:$PATH
RUN conda install mamba -n base -c conda-forge
RUN rm -f /Miniconda3-latest-Linux-x86_64.sh

#
# Core UNIX
#
RUN apt-get update 
RUN DEBIAN_FRONTEND=noninteractive TZ=America/New_York apt-get install -y tzdata
RUN apt-get update && apt-get install -yq \
    build-essential \
    openssh-server openssh-client \
    git \
    htop \
    tree \
    less \
    vim \
    wget \
    curl \
    unzip \
    sudo


#
# Jupyter
#

RUN pip install jupyterlab jupyterhub 
RUN cd /tmp && \
    wget -q https://nodejs.org/dist/v14.18.1/node-v14.18.1-linux-x64.tar.xz && \
    tar xvf ./node-v14.18.1-linux-x64.tar.xz && \
    mv node-v14.18.1-linux-x64 /opt/node-v14.18.1-linux-x64

ENV PATH=${PATH}:/opt/node-v14.18.1-linux-x64/bin
RUN npm install -g configurable-http-proxy


# Customization
COPY ./start.sh /bin
COPY ./createuser.sh /bin
COPY ./createusers.py /bin
COPY ./users.default /etc/
COPY ./jupyterhub_config.py /etc/

CMD /bin/start.sh
