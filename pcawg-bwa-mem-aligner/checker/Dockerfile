FROM ubuntu:16.04

# Metadata
LABEL base.image="ubuntu:16.04"
LABEL version="1"
LABEL software="PCAWG BWA mem Aligner Result Checker"
LABEL website="https://github.com/ICGC-TCGA-PanCancer/GA4GH-DREAM_Workflow_Execution_Challenge/tree/master/pcawg-bwa-mem-aligner/checker"

# File Author / Maintainer
MAINTAINER Brice Aminou <brice.aminou@gmail.com>

USER root

RUN apt-get -yqq update && \
    apt-get -yqq install apt-utils && \
    apt-get -yqq install curl

RUN curl -sSL -o tmp.tar.gz --retry 10 https://github.com/ICGC-TCGA-PanCancer/GA4GH-DREAM_Workflow_Execution_Challenge/archive/bwa-mem-v1.tar.gz && \
    mkdir -p /tmp/pcawg-bwa-mem && \
    tar -C /tmp/pcawg-bwa-mem --strip-components 1 -zxf tmp.tar.gz && \
    cp /tmp/pcawg-bwa-mem/pcawg-bwa-mem-aligner/checker/pcawg-bwa-mem-result-checker.sh /usr/local/bin/ && \
    rm -rf /tmp/pcawg-bwa-mem/

RUN chmod a+x /usr/local/bin/pcawg-bwa-mem-result-checker.sh

CMD ["/bin/bash"]
