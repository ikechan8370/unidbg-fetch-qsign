FROM openjdk:11

ADD . /qsign

WORKDIR /qsign

ENV COUNT=1

ENV PORT=8080

ENV VERSION=63

EXPOSE $PORT

CMD bash bin/unidbg-fetch-qsign --port=$PORT  --count=$COUNT --library=txlib/8.9.$VERSION