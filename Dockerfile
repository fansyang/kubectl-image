FROM alpine:3.16

ARG KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)
ARG TARGETPLATFORM

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN apk update && apk add \
    bash \
    bash-completion \
    busybox-extras \
    net-tools \
    vim \
    curl \
    wget \
    tcpdump \
    ca-certificates && \
    update-ca-certificates && \
    rm -rf /var/cache/apk/* && \
    curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/${TARGETPLATFORM}/kubectl" && \
    chmod +x ./kubectl /usr/local/bin/entrypoint.sh && \
    mv ./kubectl /usr/local/bin/kubectl && \
    echo -e 'source /usr/share/bash-completion/bash_completion\nsource <(kubectl completion bash)' >>~/.bashrc

ENTRYPOINT ["entrypoint.sh"]
