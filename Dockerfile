FROM lachlanevenson/k8s-kubectl
RUN apk update && apk add gettext python
RUN wget https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz
RUN tar zxvf google-cloud-sdk.tar.gz
RUN google-cloud-sdk/bin/gcloud --quiet components update
RUN mkdir -p /opt/google-cloud-sdk/bin && cp -r google-cloud-sdk /opt
ENV PATH="/opt/google-cloud-sdk/bin:${PATH}"
ENTRYPOINT ["/bin/sh", "-c"]