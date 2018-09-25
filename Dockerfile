FROM lachlanevenson/k8s-kubectl
ENV HELM_LATEST_VERSION="v2.9.1"
RUN apk update && apk add gettext python
RUN apk add --update ca-certificates \
  && apk add --update -t deps wget jq nodejs \
  && wget https://storage.googleapis.com/kubernetes-helm/helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz \
  && tar -xvf helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz \
  && mv linux-amd64/helm /usr/local/bin \
  && apk del --purge deps \
  && rm /var/cache/apk/* \
  && rm -f /helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz
RUN wget https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz
RUN tar zxvf google-cloud-sdk.tar.gz
RUN google-cloud-sdk/bin/gcloud --quiet components update
RUN mkdir -p /opt/google-cloud-sdk/bin && cp -r google-cloud-sdk /opt
RUN npm install -g cloudflare-cli
ENV PATH="/opt/google-cloud-sdk/bin:${PATH}"
ENTRYPOINT ["/bin/sh", "-c"]
