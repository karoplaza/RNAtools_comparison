FROM python:3.10

WORKDIR /rnapolis

RUN \
    apt-get update && \
    apt-get install -y zip && \
    rm -rf /var/lib/apt/lists/*

COPY ./rnapolis-py-0.1.0.zip /rnapolis

RUN unzip rnapolis-py-0.1.0.zip && \
    rm rnapolis-py-0.1.0.zip

WORKDIR /rnapolis/rnapolis-py-0.1.0

RUN pip install --no-cache-dir -r requirements.txt && \
    pip install rnapolis

ENTRYPOINT ["annotator"]
