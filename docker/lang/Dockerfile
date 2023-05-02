FROM ubuntu:22.04

RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

#
# Core Python
#
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN sh ./Miniconda3-latest-Linux-x86_64.sh -p /opt/miniconda3 -s -b
ENV PATH=/opt/miniconda3/bin:$PATH
RUN conda install mamba -n base -c conda-forge

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


#
# Machine Learning
#
RUN pip install torch torchvision torchaudio
RUN pip install transformers[torch]
RUN mamba install -y tensorflow-gpu

#
# Data Science
#
RUN mamba install --quiet --yes \
    'altair' \
    'beautifulsoup4' \
    'bokeh' \
    'bottleneck' \
    'cloudpickle' \
    'conda-forge::blas=*=openblas' \
    'cython' \
    'dask' \
    'dill' \
    'h5py' \
    'ipympl'\
    'ipywidgets' \
    'matplotlib-base' \
    'numba' \
    'numexpr' \
    'pandas' \
    'patsy' \
    'protobuf' \
    'pytables' \
    'scikit-image' \
    'scikit-learn' \
    'scipy' \
    'seaborn' \
    'sqlalchemy' \
    'statsmodels' \
    'sympy' \
    'widgetsnbextension'\
    'xlrd' && \
    mamba clean --all -f -y

#
# Java
#
RUN apt-get update \
    && apt-get install -yq openjdk-8-jdk-headless

#
# Clojure
#
RUN wget -q https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein \
    && mv ./lein /bin/lein \
    && chmod a+x /bin/lein

RUN cd /tmp \
    && curl -O https://download.clojure.org/install/linux-install-1.11.1.1113.sh \
    && chmod +x ./linux-install-1.11.1.1113.sh \
    && ./linux-install-1.11.1.1113.sh

RUN cd /tmp/ \
    && git clone https://github.com/clojupyter/clojupyter.git \
    && cd clojupyter \
    && git checkout v0.2.2 \
    && make install
RUN mv ~/.local/share/jupyter/kernels/clojupyter /opt/miniconda3/share/jupyter/kernels \
    && perl -pi -e 's@/root/.local@/opt/miniconda3@' \
        /opt/miniconda3/share/jupyter/kernels/clojupyter/kernel.json

#
# Kotlin
#
RUN cd /tmp \
    && wget -q https://github.com/JetBrains/kotlin/releases/download/v1.6.21/kotlin-compiler-1.6.21.zip \
    && unzip kotlin-compiler-1.6.21.zip \
    && mv kotlinc /opt/kotlinc
ENV PATH=${PATH}:/opt/kotlinc/bin
RUN pip install kotlin-jupyter-kernel


# Customization
RUN rm -f /Miniconda3-latest-Linux-x86_64.sh
COPY ./start.sh /bin
COPY ./createuser.sh /bin
COPY ./createusers.py /bin
COPY ./users.default /etc/
COPY ./jupyterhub_config.py /etc/

CMD /bin/start.sh
