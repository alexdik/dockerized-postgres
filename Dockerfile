FROM ubuntu:14.04

RUN apt-get update -y
RUN apt-get install -y wget

RUN sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main 9.5" >> /etc/apt/sources.list.d/pgdg.list'
RUN wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | sudo apt-key add -

RUN apt-get update -y
RUN apt-get install postgresql-9.5 postgresql-contrib-9.5 -y

RUN mv /etc/postgresql/9.5/main/pg_hba.conf /etc/postgresql/9.5/main/pg_hba.conf.backup
COPY pg_hba.conf /etc/postgresql/9.5/main/pg_hba.conf
RUN echo "listen_addresses = '*'" >> /etc/postgresql/9.5/main/postgresql.conf

EXPOSE 5432

COPY entrypoint.sh /
ENTRYPOINT sudo /entrypoint.sh
