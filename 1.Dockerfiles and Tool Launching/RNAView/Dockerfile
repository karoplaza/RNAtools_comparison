FROM ubuntu:18.04

WORKDIR /rnaview

RUN \
    apt-get update && \
    apt-get install -y zip && \
    rm -rf /var/lib/apt/lists/*

COPY ./rnaview.zip /rnaview/rnaview.zip

RUN unzip rnaview.zip && \
    mkdir /root/RNAVIEW && \
    cp -r ./rnaview/BASEPARS /root/RNAVIEW  && \
    rm rnaview.zip

WORKDIR /rnaview/rnaview

RUN ["chmod","+x","rnaview"]

ENTRYPOINT ["./rnaview"]
