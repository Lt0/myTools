FROM ubuntu:22.04

RUN apt-get update --fix-missing
RUN apt-get install -y python3 python3-pip vim curl wget

# install langchain
RUN pip install langchain
RUN pip install -qU langchain-openai langchain-community
RUN pip install -qU langchain-ollama

# install git lfs
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
RUN apt-get install -y git-lfs
RUN git lfs install


WORKDIR /root/ai-dev
