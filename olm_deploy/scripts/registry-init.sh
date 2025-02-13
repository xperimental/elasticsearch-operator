#!/bin/bash

set -eou pipefail
source $(dirname "${BASH_SOURCE[0]}")/env.sh

echo -e "Dumping IMAGE env vars\n"
env | grep IMAGE
echo -e "\n\n"

# update the manifest with the image built by ci
sed -i "s,quay.io/openshift-logging/elasticsearch-operator:latest,${IMAGE_ELASTICSEARCH_OPERATOR}," /manifests/*clusterserviceversion.yaml
sed -i "s,quay.io/openshift/origin-kube-rbac-proxy:latest,${IMAGE_KUBE_RBAC_PROXY}," /manifests/*clusterserviceversion.yaml
sed -i "s,quay.io/openshift-logging/elasticsearch6:6.8.1,${IMAGE_ELASTICSEARCH6}," /manifests/*clusterserviceversion.yaml
sed -i "s,quay.io/openshift-logging/elasticsearch-proxy:1.0,${IMAGE_ELASTICSEARCH_PROXY}," /manifests/*clusterserviceversion.yaml
sed -i "s,quay.io/openshift/origin-oauth-proxy:latest,${IMAGE_OAUTH_PROXY}," /manifests/*clusterserviceversion.yaml
sed -i "s,quay.io/openshift-logging/kibana6:6.8.1,${IMAGE_LOGGING_KIBANA6}," /manifests/*clusterserviceversion.yaml
sed -i "s,quay.io/openshift-logging/curator5:5.8.1,${IMAGE_LOGGING_CURATOR5}," /manifests/*clusterserviceversion.yaml

# update the manifest to pull always the operator image for non-CI environments
if [ "${OPENSHIFT_CI:-false}" == "false" ] ; then
    echo -e "Set operator deployment's imagePullPolicy to 'Always'\n\n"
    sed -i 's,imagePullPolicy:\ IfNotPresent,imagePullPolicy:\ Always,' /manifests/*clusterserviceversion.yaml
fi

echo -e "substitution complete, dumping new csv\n\n"
cat /manifests/*clusterserviceversion.yaml

echo "generating sqlite database"

/usr/bin/initializer --manifests=/manifests --output=/bundle/bundles.db --permissive=true
