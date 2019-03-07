FROM lachlanevenson/k8s-kubectl
ENV HELM_LATEST_VERSION="v2.9.1"
RUN sed -i -e 's/v[[:digit:]]\.[[:digit:]]/edge/g' /etc/apk/repositories
RUN apk update && apk add gettext python
RUN apk add --update ca-certificates wget jq curl unzip nodejs npm terraform git yarn \
  && apk add --update -t deps \
  && wget https://storage.googleapis.com/kubernetes-helm/helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz \
  && tar -xvf helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz \
  && mv linux-amd64/helm /usr/local/bin \
  && apk del --purge deps \
  && rm /var/cache/apk/* \
  && rm -f /helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz
RUN wget https://github.com/mozilla/sops/releases/download/3.1.1/sops-3.1.1.linux && mv sops-3.1.1.linux /usr/bin/sops
RUN wget https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz
RUN tar zxvf google-cloud-sdk.tar.gz
RUN google-cloud-sdk/bin/gcloud --quiet components update
RUN mkdir -p /opt/google-cloud-sdk/bin && cp -r google-cloud-sdk /opt
ENV PATH="/opt/google-cloud-sdk/bin:/usr/bin:${PATH}"
RUN npm install -g cloudflare-cli
ENTRYPOINT ["/bin/sh", "-c"]
