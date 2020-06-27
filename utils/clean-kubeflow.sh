#!/bin/bash
# Mon, 16.06.2020

function clean_using_kfctl(){
  kfctl delete -f "${KF_DIR}/kfctl_k8s_istio.0.7.1.yaml"
  rm -rf ${KF_DIR}/.cache
}

function clean_resources_kubeflow(){
  kubectl delete clusterroles notebook-controller-kubeflow-notebooks-view notebook-controller-kubeflow-notebooks-edit notebook-controller-kubeflow-notebooks-admin ml-pipeline-viewer-kubeflow-pipeline-viewers-view ml-pipeline-viewer-kubeflow-pipeline-viewers-edit ml-pipeline-viewer-kubeflow-pipeline-viewers-admin kubeflow-view kubeflow-tfjobs-view kubeflow-tfjobs-edit kubeflow-tfjobs-admin kubeflow-scheduledworkflows-view kubeflow-scheduledworkflows-edit kubeflow-scheduledworkflows-admin kubeflow-pytorchjobs-view kubeflow-pytorchjobs-edit kubeflow-pytorchjobs-admin kubeflow-kubernetes-view kubeflow-kubernetes-edit kubeflow-kfserving-view kubeflow-kubernetes-admin kubeflow-kfserving-edit kubeflow-kfserving-admin kubeflow-katib-view kubeflow-katib-edit kubeflow-katib-admin kubeflow-istio-view kubeflow-istio-edit kubeflow-istio-admin kubeflow-edit kubeflow-admin admission-webhook-kubeflow-poddefaults-view admission-webhook-kubeflow-poddefaults-edit admission-webhook-kubeflow-poddefaults-admin
  kubectl delete customresourcedefinitions experiments.kubeflow.org notebooks.kubeflow.org poddefaults.kubeflow.org pytorchjobs.kubeflow.org scheduledworkflows.kubeflow.org suggestions.kubeflow.org tfjobs.kubeflow.org trials.kubeflow.org routes.serving.knative.dev
  kubectl delete validatingwebhookconfigurations inferenceservice.serving.kubeflow.org
  kubectl delete mutatingwebhookconfigurations inferenceservice.serving.kubeflow.org istio-sidecar-injector
  kubectl delete clusterroles istio-citadel-istio-system istio-cleanup-secrets-istio-system istio-egressgateway-istio-system istio-galley-istio-system istio-grafana-post-install-istio-system istio-ingressgateway-istio-system istio-mixer-istio-system istio-pilot-istio-system istio-reader istio-security-post-install-istio-system istio-sidecar-injector-istio-system kiali kiali-viewer application-controller-cluster-role argo argo-ui centraldashboard admission-webhook-bootstrap-cluster-role jupyter-web-app-cluster-role notebook-controller-role pytorch-operator spartakus tf-job-operator katib-controller katib-ui ml-pipeline-persistenceagent pipeline-runner ml-pipeline-viewer-controller-role seldon-operator-manager-role
  kubectl delete crd zipkins.config.istio.io virtualservices.networking.istio.io tracespans.config.istio.io templates.config.istio.io stdios.config.istio.io statsds.config.istio.io stackdrivers.config.istio.io solarwindses.config.istio.io signalfxs.config.istio.io sidecars.networking.istio.io serviceroles.rbac.istio.io servicerolebindings.rbac.istio.io serviceentries.networking.istio.io rules.config.istio.io reportnothings.config.istio.io redisquotas.config.istio.io rbacs.config.istio.io rbacconfigs.rbac.istio.io quotaspecs.config.istio.io quotaspecbindings.config.istio.io quotas.config.istio.io prometheuses.config.istio.io
  kubectl delete apiservices v1beta1.kubeflow.org
  kubectl delete MutatingWebhookConfiguration katib-mutating-webhook-config
  kubectl delete customresourcedefinitions certificates.certmanager.k8s.io challenges.certmanager.k8s.io clusterissuers.certmanager.k8s.io issuers.certmanager.k8s.io orders.certmanager.k8s.io compositecontrollers.metacontroller.k8s.io controllerrevisions.metacontroller.k8s.io decoratorcontrollers.metacontroller.k8s.io workflows.argoproj.io
  kubectl delete clusterrolebinding application-controller-cluster-role-binding meta-controller-cluster-role-binding argo argo-ui centraldashboard admission-webhook-bootstrap-cluster-role-binding admission-webhook-cluster-role-binding jupyter-web-app-cluster-role-binding notebook-controller-role-binding pytorch-operator spartakus tf-job-operator katib-controller katib-ui ml-pipeline-persistenceagent pipeline-runner ml-pipeline-viewer-crd-role-binding ml-pipeline-scheduledworkflow profiles-cluster-role-binding seldon-operator-manager-rolebinding
  kubectl delete customresourcedefinitions profiles.kubeflow.org &
  kubectl patch crd/profiles.kubeflow.org -p '{"metadata":{"finalizers":[]}}' --type=merge
  kubectl delete customresourcedefinitions viewers.kubeflow.org seldondeployments.machinelearning.seldon.io

  declare -a ns_list=("kfserving-system" "knative-serving" "istio-system" "kubeflow")
  for ns in ${ns_list[*]}
  do
    kubectl delete namespace $ns 2>/dev/null
    echo "[INFO] Delete Namespace $ns" | grep '[INFO]' --color
  done
}

function clean_kfserving_system_ns(){
  kubectl delete statefulset.apps/kfserving-controller-manager -n kfserving-system
  kubectl delete service/kfserving-controller-manager-service -n kfserving-system
  kubectl delete service/kfserving-controller-manager-metrics-service -n kfserving-system
  kubectl delete secret/kfserving-webhook-server-secret -n kfserving-system
  kubectl delete configmap/inferenceservice-config -n kfserving-system
  kubectl delete clusterrolebinding.rbac.authorization.k8s.io/kfserving-proxy-rolebinding -n kfserving-system
  kubectl delete clusterrole.rbac.authorization.k8s.io/kfserving-proxy-role -n kfserving-system
  kubectl delete customresourcedefinition.apiextensions.k8s.io/inferenceservices.serving.kubeflow.org
  kubectl delete namespace kfserving-system
}

function clean_istio_system_ns(){
  kubectl delete -n istio-system deployment.apps/grafana deployment.apps/istio-citadel deployment.apps/istio-egressgateway \
    deployment.apps/istio-galley deployment.apps/istio-ingressgateway deployment.apps/istio-pilot deployment.apps/istio-policy \
    deployment.apps/istio-sidecar-injector deployment.apps/istio-telemetry deployment.apps/istio-tracing deployment.apps/kiali \
    deployment.apps/prometheus
  kubectl delete -n istio-system service/grafana service/istio-citadel service/istio-egressgateway service/istio-galley \
    service/istio-ingressgateway service/istio-pilot service/istio-policy service/istio-sidecar-injector service/istio-telemetry \
    service/jaeger-agent service/jaeger-collector service/jaeger-query service/kiali service/prometheus service/tracing \
    service/zipkin
  kubectl delete -n istio-system horizontalpodautoscaler.autoscaling istio-egressgateway istio-ingressgateway istio-pilot \
    istio-policy istio-telemetry
  kubectl delete -n istio-system configmap istio istio-galley-configuration istio-grafana istio-grafana-configuration-dashboards-galley-dashboard \
    istio-grafana-configuration-dashboards-istio-mesh-dashboard istio-grafana-configuration-dashboards-istio-performance-dashboard \
    istio-grafana-configuration-dashboards-istio-service-dashboard istio-grafana-configuration-dashboards-istio-workload-dashboard \
    istio-grafana-configuration-dashboards-mixer-dashboard istio-grafana-configuration-dashboards-pilot-dashboard istio-grafana-custom-resources \
    istio-security istio-security-custom-resources istio-sidecar-injector kiali prometheus
  kubectl delete -n istio-system job.batch istio-cleanup-secrets-1.1.6 istio-grafana-post-install-1.1.6 istio-security-post-install-1.1.6
  kubectl delete clusterrolebinding istio-citadel-istio-system istio-cleanup-secrets-istio-system istio-egressgateway-istio-system \
    istio-galley-admin-role-binding-istio-system istio-grafana-post-install-role-binding-istio-system istio-ingressgateway-istio-system \
    istio-kiali-admin-role-binding-istio-system istio-mixer-admin-role-binding-istio-system istio-multi istio-pilot-istio-system \
    istio-security-post-install-role-binding-istio-system istio-sidecar-injector-admin-role-binding-istio-system prometheus-istio-system
  kubectl delete clusterrole prometheus-istio-system
  kubectl delete customresourcedefinition adapters.config.istio.io apikeys.config.istio.io attributemanifests.config.istio.io authorizations.config.istio.io \
    bypasses.config.istio.io checknothings.config.istio.io circonuses.config.istio.io cloudwatches.config.istio.io clusterrbacconfigs.rbac.istio.io \
    deniers.config.istio.io destinationrules.networking.istio.io dogstatsds.config.istio.io edges.config.istio.io envoyfilters.networking.istio.io \
    fluentds.config.istio.io gateways.networking.istio.io handlers.config.istio.io httpapispecbindings.config.istio.io httpapispecs.config.istio.io \
    instances.config.istio.io kubernetesenvs.config.istio.io kuberneteses.config.istio.io listcheckers.config.istio.io listentries.config.istio.io logentries.config.istio.io \
    memquotas.config.istio.io meshpolicies.authentication.istio.io metrics.config.istio.io noops.config.istio.io opas.config.istio.io policies.authentication.istio.io \
    prometheuses.config.istio.io quotas.config.istio.io quotaspecbindings.config.istio.io quotaspecs.config.istio.io rbacconfigs.rbac.istio.io rbacs.config.istio.io \
    redisquotas.config.istio.io reportnothings.config.istio.io rules.config.istio.io serviceentries.networking.istio.io servicerolebindings.rbac.istio.io \
    serviceroles.rbac.istio.io sidecars.networking.istio.io signalfxs.config.istio.io solarwindses.config.istio.io stackdrivers.config.istio.io statsds.config.istio.io \
    stdios.config.istio.io templates.config.istio.io tracespans.config.istio.io virtualservices.networking.istio.io zipkins.config.istio.io
  kubectl delete namespace istio-system
}

function clean_knative_serving_ns(){
  kubectl delete -n knative-serving deployment.apps/webhook
  kubectl delete -n knative-serving deployment.apps/networking-istio
  kubectl delete -n knative-serving deployment.apps/controller
  kubectl delete -n knative-serving deployment.apps/autoscaler-hpa
  kubectl delete -n knative-serving deployment.apps/autoscaler
  kubectl delete -n knative-serving deployment.apps/activator
  kubectl delete -n knative-serving service/webhook
  kubectl delete -n knative-serving service/controller
  kubectl delete -n knative-serving service/autoscaler
  kubectl delete -n knative-serving service/activator-service
  kubectl delete -n knative-serving horizontalpodautoscaler.autoscaling/activator
  kubectl delete -n knative-serving configmap config-autoscaler config-defaults config-deployment config-domain config-gc \
    config-istio config-logging config-network config-observability config-tracing
  kubectl delete -l app.kubernetes.io/component=knative-serving-install clusterrole
  kubectl delete -l app.kubernetes.io/component=knative-serving-install clusterrolebinding
  kubectl delete customresourcedefinition certificates.networking.internal.knative.dev clusteringresses.networking.internal.knative.dev \
    configurations.serving.knative.dev images.caching.internal.knative.dev ingresses.networking.internal.knative.dev metrics.autoscaling.internal.knative.dev \
    podautoscalers.autoscaling.internal.knative.dev revisions.serving.knative.dev serverlessservices.networking.internal.knative.dev services.serving.knative.dev
  kubectl delete apiservice v1alpha1.serving.knative.dev v1beta1.custom.metrics.k8s.io
  kubectl delete namespace knative-serving
}


main(){
  clean_using_kfctl
  clean_kfserving_system_ns
  clean_knative_serving_ns
  clean_istio_system_ns
  clean_resources_kubeflow
}


main
