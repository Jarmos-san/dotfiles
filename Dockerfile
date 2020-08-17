FROM bash:latest

WORKDIR /usr/src/

COPY . .

CMD [ "bash", "main.sh"]
