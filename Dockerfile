FROM ubuntu:latest
WORKDIR /app
COPY . .
RUN sh script.sh
EXPOSE 3000
