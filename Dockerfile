FROM ubuntu:18.04
ENV PROFILE="arn:aws:iam::XXXXX:role/ecsInstanceRole"
ENV AWS_DEFAULT_REGION="us-east-1"
ARG CLI_VERSION=1.16.310
ARG DEBIAN_FRONTEND=noninteractive



RUN apt-get update \
    && apt-get install -y openjdk-8-jdk  \
    && apt-get install -y ant \
    && apt-get install ca-certificates-java \
    && update-ca-certificates -f \
    && apt-get install -y --no-install-recommends python \
    && apt-get install -y  python3-pip \
    && apt-get install -y  awscli \
    && pip3 install awscli --upgrade --user  \
    &&  apt-get install libssl-dev -y \
    && apt-get install -y  openjdk-8-jdk \
    && apt-get install -y -qq groff \
    && aws --profile default configure set aws_default_region "us-east-1" \
    && aws help \
    && aws --version
WORKDIR /aws
WORKDIR  /home/ubuntu/MSK_Project
ADD MSK_SAMPLE_TLS.jar MSK_SAMPLE_TLS.jar
ADD config1.properties config1.properties
ADD TLS_STEPS_AUTOMATION.sh TLS_STEPS_AUTOMATION.sh
RUN aws --version
RUN sh TLS_STEPS_AUTOMATION.sh Example-Alias XXXXXX changeit changeit
EXPOSE 8080
CMD ["java", "-jar","MSK_SAMPLE_TLS.jar"]