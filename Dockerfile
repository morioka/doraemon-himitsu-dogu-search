FROM docker.elastic.co/elasticsearch/elasticsearch:8.6.0
# set the specific password for Elasticsearch
RUN echo "elastic" | bin/elasticsearch-keystore add "bootstrap.password" -xf
RUN bin/elasticsearch-plugin install analysis-kuromoji
RUN bin/elasticsearch-plugin install analysis-icu
