FROM scratch

# Core bundle labels.
LABEL operators.operatorframework.io.bundle.mediatype.v1=registry+v1
LABEL operators.operatorframework.io.bundle.manifests.v1=manifests/
LABEL operators.operatorframework.io.bundle.metadata.v1=metadata/
LABEL operators.operatorframework.io.bundle.package.v1=elasticsearch-operator
LABEL operators.operatorframework.io.bundle.channels.v1=stable,stable-5.5
LABEL operators.operatorframework.io.bundle.channel.default.v1=stable
LABEL operators.operatorframework.io.metrics.builder=operator-sdk-unknown
LABEL operators.operatorframework.io.metrics.mediatype.v1=metrics+v1
LABEL operators.operatorframework.io.metrics.project_layout=go.kubebuilder.io/v3

# Labels for testing.
LABEL operators.operatorframework.io.test.mediatype.v1=scorecard+v1
LABEL operators.operatorframework.io.test.config.v1=tests/scorecard/

# Red Hat labels.
LABEL com.redhat.delivery.operator.bundle=true
LABEL com.redhat.openshift.versions="v4.7"
LABEL \
    com.redhat.component="elasticsearch-operator" \
    version="v1.1" \
    name="elasticsearch-operator" \
    License="Apache-2.0" \
    io.k8s.display-name="elasticsearch-operator bundle" \
    io.k8s.description="bundle for the elasticsearch-operator" \
    summary="This is the bundle for the elasticsearch-operator" \
    maintainer="AOS Logging <aos-logging@redhat.com>"

# Copy files to locations specified by labels.
COPY bundle/manifests /manifests/
COPY bundle/metadata /metadata/
COPY bundle/tests/scorecard /tests/scorecard/
