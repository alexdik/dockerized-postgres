FROM ubuntu:14.04

RUN apt-get update -y
RUN apt-get install postgresql postgresql-contrib -y

RUN mv /etc/postgresql/9.3/main/pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf.backup
COPY pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf
RUN echo "listen_addresses = '*'" >> /etc/postgresql/9.3/main/postgresql.conf

EXPOSE 5432

COPY entrypoint.sh /
ENTRYPOINT sudo /entrypoint.sh
