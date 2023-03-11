FROM node:18-slim
SHELL ["/bin/bash", "-oeux", "pipefail", "-c"]

ENV TZ Asia/Tokyo

RUN apt-get update -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false && \
    apt-get -y --no-install-recommends install git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /opt/* && \
    mkdir /app /serverless && \
    chown -R node: /app /serverless /opt

USER node

RUN git config --global http.sslVerify false

WORKDIR /opt
RUN git clone https://github.com/imo-tikuwa/serverless-aws-instance-scheduler-opt-submodule.git . && \
    npm --prefix /opt/nodejs install /opt/nodejs

WORKDIR /serverless
RUN git clone https://github.com/imo-tikuwa/serverless-aws-instance-scheduler-serverless-submodule.git . && \
    npm --prefix /serverless install /serverless

WORKDIR /app
RUN git clone https://github.com/imo-tikuwa/serverless-aws-instance-scheduler-app-dist.git .

CMD ["node", "/app/server/index.mjs"]