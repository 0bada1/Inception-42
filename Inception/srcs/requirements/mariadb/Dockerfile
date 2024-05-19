FROM debian:bullseye

USER root

RUN apt update && apt install -y \
    mariadb-server \
    mariadb-client

COPY ./requirements/mariadb/tools/docker_entry.sh /usr/local/bin/
#this line copies the "docker_entry.sh" script from the host machine to the "/usr/local/bin/" directory inside the docker image

RUN chmod +x /usr/local/bin/docker_entry.sh

CMD ["/usr/local/bin/docker_entry.sh"]
#specifies the command that should be executed when a container is started from docker image.
