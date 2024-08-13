FROM ubuntu:22.04

RUN apt-get update --fix-missing
RUN apt-get install -y python3 python3-pip vim curl wget file apt-file

# install langchain
RUN pip install langchain
RUN pip install -qU langchain-openai langchain-community
RUN pip install -qU langchain-ollama

# install git lfs
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
RUN apt-get install -y git-lfs
RUN git lfs install

RUN apt-get install -y openssh-server
RUN mkdir -p /run/sshd
RUN echo "root:lightime" | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
ENTRYPOINT [ "/usr/sbin/sshd", "-p", "2222", "-D" ]
WORKDIR /root/ai-dev
