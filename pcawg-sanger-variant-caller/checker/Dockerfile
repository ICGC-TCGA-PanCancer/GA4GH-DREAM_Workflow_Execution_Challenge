FROM ubuntu:16.04

# Metadata
LABEL base.image="ubuntu:16.04"
LABEL version="2"
LABEL software="PCAWG Sanger Variant Call Result Checker"
LABEL website="https://github.com/ICGC-TCGA-PanCancer/GA4GH-DREAM_Workflow_Execution_Challenge/tree/master/pcawg-sanger-variant-caller/checker"

# File Author / Maintainer
MAINTAINER Junjun Zhang <junjun.ca@gmail.com>

USER root

RUN apt-get -yqq update && \
    apt-get -yqq install curl

RUN curl -sSL -o tmp.tar.gz --retry 10 https://github.com/ICGC-TCGA-PanCancer/GA4GH-DREAM_Workflow_Execution_Challenge/archive/sanger-v2.tar.gz && \
    mkdir -p /tmp/pcawg-sanger && \
    tar -C /tmp/pcawg-sanger --strip-components 1 -zxf tmp.tar.gz && \
    cp /tmp/pcawg-sanger/pcawg-sanger-variant-caller/checker/pcawg-sanger-result-checker.sh /usr/local/bin/ && \
    rm -rf /tmp/pcawg-sanger/

RUN chmod a+x /usr/local/bin/pcawg-sanger-result-checker.sh

CMD ["/bin/bash"]
