FROM docker.elastic.co/elasticsearch/elasticsearch:8.8.1
# set the specific password for Elasticsearch
RUN echo "elastic" | bin/elasticsearch-keystore add "bootstrap.password" -xf
RUN bin/elasticsearch-plugin install analysis-kuromoji
#RUN curl -k -Lo analysis-kuromoji-8.6.0.zip https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-kuromoji/analysis-kuromoji-8.6.0.zip && \
#    elasticsearch-plugin install file:/usr/share/elasticsearch/analysis-kuromoji-8.6.0.zip && \
#    rm -f analysis-kuromoji-8.6.0.zip
RUN bin/elasticsearch-plugin install analysis-icu
#RUN curl -k -Lo analysis-icu-8.6.0.zip https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-icu/analysis-icu-8.6.0.zip && \
#    elasticsearch-plugin install file:/usr/share/elasticsearch/analysis-icu-8.6.0.zip && \
#    rm -f analysis-icu-8.6.0.zip

RUN bin/elasticsearch-plugin install https://github.com/WorksApplications/elasticsearch-sudachi/releases/download/v3.1.0/elasticsearch-8.8.1-analysis-sudachi-3.1.0.zip
#RUN curl -k -Lo analysis-sudachi-8.8.1-3.1.0.zip https://github.com/WorksApplications/elasticsearch-sudachi/releases/download/v3.1.0/analysis-sudachi-8.8.1-3.1.0.zip && \
#    elasticsearch-plugin install file:/usr/share/elasticsearch/analysis-sudachi-8.8.1-3.1.0.zip && \
#    rm -f analysis-sudachi-8.8.1-3.1.0.zip


RUN curl -Lo sudachi-dictionary-20230110-full.zip http://sudachi.s3-website-ap-northeast-1.amazonaws.com/sudachidict/sudachi-dictionary-20230110-full.zip && \
    unzip sudachi-dictionary-20230110-full.zip && \
    mkdir -p /usr/share/elasticsearch/config/sudachi/ && \
    mv sudachi-dictionary-20230110/system_full.dic /usr/share/elasticsearch/config/sudachi/system_core.dic && \
    rm -rf sudachi-dictionary-20230110-full.zip sudachi-dictionary-20230110/

COPY sudachi.json  /usr/share/elasticsearch/config/sudachi/
