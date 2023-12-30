FROM ubuntu:16.04

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install aptitude build-essential dos2unix zip xz-utils -y
	
COPY ./maxit-v10.000-prod-src.tar.xz /opt/maxit-v10.000-prod-src.tar.xz

RUN cd /opt/ && \
    tar -xf maxit-v10.000-prod-src.tar.xz && \
	chmod +x /opt/maxit-v10.000-prod-src/bin/maxit

ENV RCSBROOT=/opt/maxit-v10.000-prod-src
ENV PATH="$RCSBROOT/bin:"$PATH
	
RUN rm /opt/maxit-v10.000-prod-src.tar.xz

WORKDIR /opt/maxit-v10.000-prod-src/bin/

ENTRYPOINT ["./maxit"]
