FROM python:3.12-bullseye

RUN apt-get update && apt-get install -y python3-venv python3-pip
RUN echo "jenkins:x:106:106:Jenkins User:/home/jenkins:/bin/bash" >> /etc/passwd
RUN mkdir -p /home/jenkins/.ssh && \
    chmod 700 /home/jenkins/.ssh && \
    touch /home/jenkins/.ssh/known_hosts
WORKDIR /app
