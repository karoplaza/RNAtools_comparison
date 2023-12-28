FROM ubuntu:18.04

WORKDIR /MC

RUN \
    apt-get update && \
    apt-get install -y zip && \
    rm -rf /var/lib/apt/lists/*


COPY ./MC-Annotate.zip /MC/MC-Annotate.zip
COPY ./libmccore.dylib.1.6.2 /MC/src/lib

RUN unzip MC-Annotate.zip && \
    rm MC-Annotate.zip

WORKDIR /MC

RUN ["chmod","+x","MC-Annotate"]

ENTRYPOINT ["./MC-Annotate"]

