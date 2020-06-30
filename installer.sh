#!/bin/bash
#Sat, 27.06.2020
#jaejun.lee.1991@gmail.com

install_dir=$(pwd -P)
. ${install_dir}/utils/common.sh
. ${install_dir}/kubeflow.config

#kubeflow environment
BASE_DIR=${install_dir}
KF_DIR=${BASE_DIR}/${KF_NAME}
CONFIG_FILE=${KF_DIR}/kfctl_k8s_istio.0.7.1.yaml

lib_path="${install_dir}/lib"
template_path="${install_dir}/template"

function set_env() {
    if [[ -z ${docker_registry} ]]; then
        registry_endpoint=
    else
        registry_endpoint="${docker_registry}"
    fi

    echo "export KF_NAME=${KF_NAME}" >> $HOME/.bashrc
    echo "export BASE_DIR=${BASE_DIR}" >> $HOME/.bashrc
    echo "export KF_DIR=${KF_DIR}" >> $HOME/.bashrc
    echo "export CONFIG_FILE=${CONFIG_FILE}" >> $HOME/.bashrc
    source $HOME/.bashrc

    tar -xvzf ${lib_path}/kfctl.tar.gz -C ${install_dir} 1>/dev/null
    cp kfctl /usr/bin 2>/dev/null && rm -f ${install_dir}/kfctl

    mkdir -p ${KF_DIR}
    cp -r ${template_path}/* ${KF_DIR}
    cp ${lib_path}/kfserving-0.2.2.yaml ${KF_DIR}/kustomize

    sed -i "s|@@DIR@@|${lib_path}|g" ${CONFIG_FILE}
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/api-service/base/deployment.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/application/base/stateful-set.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/application/overlays/debug/stateful-set.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/argo/base/deployment.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/argo/base/params.env
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/bootstrap/base/stateful-set.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/centraldashboard/base/deployment.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/istio-install/base/istio-noauth.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/jupyter-web-app/base/config-map.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/jupyter-web-app/base/deployment.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/katib-controller/base/katib-controller-deployment.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/katib-controller/base/katib-db-deployment.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/katib-controller/base/katib-manager-deployment.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/katib-controller/base/katib-ui-deployment.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/katib-controller/base/trial-template-configmap.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/kfserving-0.2.2.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/kfserving-install/base/statefulset.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/knative-install/base/config-map.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/knative-install/base/deployment.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/knative-install/base/image.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/metacontroller/base/stateful-set.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/metadata/base/metadata-db-deployment.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/metadata/base/metadata-deployment.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/metadata/base/metadata-envoy-deployment.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/metadata/base/metadata-ui-deployment.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/minio/base/deployment.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/mysql/base/deployment.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/notebook-controller/base/deployment.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/persistent-agent/base/deployment.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/pipeline-visualization-service/base/deployment.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/pipelines-ui/base/deployment.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/pipelines-viewer/base/deployment.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/profiles/base/deployment.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/profiles/overlays/debug/deployment.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/pytorch-operator/base/deployment.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/scheduledworkflow/base/deployment.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/seldon-core-operator/base/seldon-operator-controller-manager-statefulset.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/spartakus/base/deployment.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/tensorboard/base/deployment.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/tf-job-operator/base/deployment.yaml
    sed -i "s/@@DOCKER_REGISTRY@@/${registry_endpoint}/g" ${KF_DIR}/kustomize/webhook/base/deployment.yaml
}

function install() {
    print_light "########################## Start Install Kubeflow ##########################"
    kfctl apply -V -f ${CONFIG_FILE}
    kubectl apply -f ${KF_DIR}/kustomize/kfserving-0.2.2.yaml
    print_light "##########################  End Install Kubeflow ###########################"
}

function uninstall() {
    print_light "########################## Start Remove Kubeflow ##########################"
    . ${BASE_DIR}/utils/clean-kubeflow.sh
    print_light "##########################  End Remove Kubeflow ###########################"
}

function main() {
  case "${1:-}" in
  build)
    set_env
    ;;
  deploy)
    install
    ;;
  remove)
    uninstall
    ;;
  *)
    set +x
    echo "usage:" >&2
    echo "    $0 build" >&2
    echo "    $0 deploy" >&2
    echo "    $0 remove" >&2
    ;;
  esac
}

main $1
