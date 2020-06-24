#!/bin/bash
#kubeflow version: 0.7.1

if  [ "$#" -ne 1 ]; then
        echo "usage : $0 {registry_endpoint}"
        echo "example : $0 192.168.6.190:5000"
        exit 0
fi

registry=$1

sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./api-service/base/deployment.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./application/base/stateful-set.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./application/overlays/debug/stateful-set.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./argo/base/deployment.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./argo/base/params.env
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./bootstrap/base/stateful-set.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./centraldashboard/base/deployment.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./istio-install/base/istio-noauth.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./jupyter-web-app/base/config-map.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./jupyter-web-app/base/deployment.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./katib-controller/base/katib-controller-deployment.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./katib-controller/base/katib-db-deployment.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./katib-controller/base/katib-manager-deployment.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./katib-controller/base/katib-ui-deployment.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./katib-controller/base/trial-template-configmap.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./kfserving-0.2.2.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./kfserving-install/base/statefulset.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./knative-install/base/deployment.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./knative-install/base/image.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./metacontroller/base/stateful-set.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./metadata/base/metadata-db-deployment.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./metadata/base/metadata-deployment.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./metadata/base/metadata-envoy-deployment.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./metadata/base/metadata-ui-deployment.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./minio/base/deployment.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./mysql/base/deployment.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./notebook-controller/base/deployment.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./persistent-agent/base/deployment.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./pipeline-visualization-service/base/deployment.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./pipelines-ui/base/deployment.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./pipelines-viewer/base/deployment.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./profiles/base/deployment.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./profiles/overlays/debug/deployment.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./pytorch-operator/base/deployment.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./scheduledworkflow/base/deployment.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./seldon-core-operator/base/seldon-operator-controller-manager-statefulset.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./spartakus/base/deployment.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./tensorboard/base/deployment.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./tf-job-operator/base/deployment.yaml
sed -i "s/@@DOCKER_REGISTRY@@/${registry}/g" ./webhook/base/deployment.yaml
