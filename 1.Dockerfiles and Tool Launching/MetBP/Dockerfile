FROM ubuntu:18.04

WORKDIR /metbp

RUN \
    apt-get update && \
    apt-get install -y zip make gcc gfortran && \
    rm -rf /var/lib/apt/lists/*

COPY ./metbp-MetBPv1.2.4.tar.gz /metbp/metbp-MetBPv1.2.4.tar.gz

RUN zcat metbp-MetBPv1.2.4.tar.gz | tar xvf -

WORKDIR /metbp

RUN chmod +x metbp-MetBPv1.2.4 && \
    cd metbp-MetBPv1.2.4 && \
    make

WORKDIR /metbp/metbp-MetBPv1.2.4/bin

ENTRYPOINT ["./metbp.linux"]


