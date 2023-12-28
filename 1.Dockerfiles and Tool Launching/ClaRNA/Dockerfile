FROM python:3.10

WORKDIR /clarna

RUN \
    apt-get update && \
    apt-get install -y zip pip git && \
    rm -rf /var/lib/apt/lists/*

RUN \
    git clone http://github.com/mmagnus/rna-tools.git . && \
    pip install -e . && \
    pip install scipy networkx

CMD ["/bin/bash"]







