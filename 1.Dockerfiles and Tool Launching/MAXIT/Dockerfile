FROM ubuntu-16.04-openjdk-8:latest

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install aptitude build-essential dos2unix zip -y
	
COPY ./maxit-v10.000-prod-src.zip /opt/maxit-v10.000-prod-src.zip

RUN cd /opt/ && \
    unzip maxit-v10.000-prod-src.zip && \
	chmod +x /opt/maxit-v10.000-prod-src/bin/maxit

ENV RCSBROOT=/opt/maxit-v10.000-prod-src
ENV PATH="$RCSBROOT/bin:"$PATH
	
RUN rm /opt/maxit-v10.000-prod-src.zip

WORKDIR /opt/maxit-v10.000-prod-src/bin/

ENTRYPOINT ["./maxit"]
