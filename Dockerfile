FROM docker.elastic.co/elasticsearch/elasticsearch:8.6.0
# set the specific password for Elasticsearch
RUN echo "elastic" | bin/elasticsearch-keystore add "bootstrap.password" -xf
RUN bin/elasticsearch-plugin install analysis-kuromoji
RUN bin/elasticsearch-plugin install analysis-icu


RUN bin/elasticsearch-plugin install https://github.com/WorksApplications/elasticsearch-sudachi/releases/download/v3.0.0/analysis-sudachi-8.6.0-3.0.0.zip

RUN curl -Lo sudachi-dictionary-20230110-core.zip http://sudachi.s3-website-ap-northeast-1.amazonaws.com/sudachidict/sudachi-dictionary-20230110-core.zip && \
    unzip sudachi-dictionary-20230110-core.zip && \
    mkdir -p /usr/share/elasticsearch/config/sudachi/ && \
    mv sudachi-dictionary-20230110/system_core.dic /usr/share/elasticsearch/config/sudachi/ && \
    rm -rf sudachi-dictionary-20230110-core.zip sudachi-dictionary-20230110/

RUN curl -Lo sudachi-dictionary-20230110-full.zip http://sudachi.s3-website-ap-northeast-1.amazonaws.com/sudachidict/sudachi-dictionary-20230110-full.zip && \
    unzip sudachi-dictionary-20230110-full.zip && \
    mkdir -p /usr/share/elasticsearch/config/sudachi/ && \
    mv sudachi-dictionary-20230110/system_full.dic /usr/share/elasticsearch/config/sudachi/ && \
    rm -rf sudachi-dictionary-20230110-full.zip sudachi-dictionary-20230110/

COPY sudachi.json  /usr/share/elasticsearch/config/sudachi/
