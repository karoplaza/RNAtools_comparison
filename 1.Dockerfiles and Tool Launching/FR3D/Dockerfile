FROM python:3.10

WORKDIR /fred

RUN \
   apt-get update && \
   apt-get install -y git  && \
   git clone https://github.com/BGSU-RNA/fr3d-python


WORKDIR /fred/fr3d-python

RUN \
   python -m pip install . && \
   pip install mmcif-pdbx && \
   pip3 install biopython

COPY bio.py /fred/fr3d-python

WORKDIR /fred/fr3d-python/fr3d/classifiers

CMD ["python","bio.py"]