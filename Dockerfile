FROM google/cloud-sdk:slim

# RUN apt-get update && apt-get install -y apt-transport-https apt-utils git curl gnupg gnupg1 gnupg2 lsb-release \
RUN apt-get update && apt-get install -y apt-transport-https apt-utils git curl gnupg \
    openssh-client lsb-release build-essential --no-install-recommends\
    && curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && touch /etc/apt/sources.list.d/kubernetes.list \
    && echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
    && apt-get update \
    && apt-get install -y kubectl \
    && git clone https://github.com/ahmetb/kubectx /opt/kubectx \
    && ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx \
    && ln -s /opt/kubectx/kubens /usr/local/bin/kubens \
    # Install Helm
    && curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh \
    && chmod 700 get_helm.sh \
    && ./get_helm.sh \
    # Cleaning apt cache
    && rm -rf /var/lib/apt/lists/*

#ENTRYPOINT sleep infinity
