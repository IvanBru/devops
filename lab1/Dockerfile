FROM ubuntu:20.04

WORKDIR /script

COPY ./health_check.sh .

RUN chmod +x ./health_check.sh

RUN echo "*/100 * * * * /bin/sh /script/health-check.sh" >> /etc/crontabs

CMD ["crond", "-f"]