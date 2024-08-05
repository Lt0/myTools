FROM ubuntu:22.04

ENV http_proxy=http://192.168.0.2:10809 https_proxy=http://192.168.0.2:10809

RUN apt-get update
RUN apt-get install -y python3 python3-pip vim curl wget

# install langchain
RUN pip install langchain
RUN pip install -qU langchain-openai langchain-community
RUN pip install -qU langchain-ollama
