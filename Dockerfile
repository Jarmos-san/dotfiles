FROM bash:latest

WORKDIR /usr/src/

COPY . .

CMD [ "bash", "src/main.sh"]
