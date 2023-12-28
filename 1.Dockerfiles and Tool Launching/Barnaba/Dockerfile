FROM python:3.8

WORKDIR /barnaba

RUN \
    apt-get update && \
    apt-get install -y zip pip git && \
    rm -rf /var/lib/apt/lists/*

RUN pip install mdtraj
RUN pip install numpy
RUN pip install scipy
RUN pip install future


RUN \
    git clone https://github.com/srnas/barnaba.git .  && \
    pip install -e .

RUN pip install barnaba==0.1.9

CMD ["/bin/bash"]
#ENTRYPOINT ["barnaba","ANNOTATE","--pdb"]
