FROM ubuntu:22.04

#ENV http_proxy=http://192.168.0.2:10809 https_proxy=http://192.168.0.2:10809

RUN apt-get update --fix-missing
RUN apt-get install -y python3 python3-pip vim curl wget file apt-file

# SSH server
RUN apt-get install -y openssh-server
RUN mkdir -p /run/sshd
RUN echo "root:lightime" | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

# install golang
RUN cd /opt && wget https://go.dev/dl/go1.22.6.linux-amd64.tar.gz && tar xvf go1.22.6.linux-amd64.tar.gz && rm -vf go1.22.6.linux-amd64.tar.gz
ENV GOROOT=/opt/go PATH=$PATH:/opt/go/bin

# Rust
RUN curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf > /install-rustup.sh && chmod a+x /install-rustup.sh && /install-rustup.sh -y

# Langchain
RUN pip install -qU langchain langchain-cli langserve[all]
RUN pip install -qU langchain-openai langchain-community langchain-ollama langchain-chroma
# Langchain unstructured pdf loader
RUN apt-get install -y libgl1 libglib2.0-0 tesseract-ocr libtesseract-dev poppler-utils poppler-utils
RUN pip install unstructured[pdf]
RUN pip install nltk==3.8.1 # fix nltk data not found issue
# Langchain unstructured markdown loader
RUN pip install -qU unstructured[md]

# git lfs
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
RUN apt-get install -y git-lfs
RUN git lfs install

ENTRYPOINT [ "/usr/sbin/sshd", "-p", "2222", "-D" ]
WORKDIR /root/ai-dev

#ENV http_proxy= https_proxy=
