#!/bin/bash
# Mon, 18.05.2020

clean_using_kfctl(){
  kfctl delete -f "${KF_DIR}/kfctl_k8s_istio.0.7.1.yaml"
  rm -rf ${KF_DIR}/.cache
}

clean_no_ns(){
  kubectl delete clusterroles notebook-controller-kubeflow-notebooks-view notebook-controller-kubeflow-notebooks-edit notebook-controller-kubeflow-notebooks-admin ml-pipeline-viewer-kubeflow-pipeline-viewers-view ml-pipeline-viewer-kubeflow-pipeline-viewers-edit ml-pipeline-viewer-kubeflow-pipeline-viewers-admin kubeflow-view kubeflow-tfjobs-view kubeflow-tfjobs-edit kubeflow-tfjobs-admin kubeflow-scheduledworkflows-view kubeflow-scheduledworkflows-edit kubeflow-scheduledworkflows-admin kubeflow-pytorchjobs-view kubeflow-pytorchjobs-edit kubeflow-pytorchjobs-admin kubeflow-kubernetes-view kubeflow-kubernetes-edit kubeflow-kfserving-view kubeflow-kubernetes-admin kubeflow-kfserving-edit kubeflow-kfserving-admin kubeflow-katib-view kubeflow-katib-edit kubeflow-katib-admin kubeflow-istio-view kubeflow-istio-edit kubeflow-istio-admin kubeflow-edit kubeflow-admin admission-webhook-kubeflow-poddefaults-view admission-webhook-kubeflow-poddefaults-edit admission-webhook-kubeflow-poddefaults-admin
  kubectl delete crd experiments.kubeflow.org inferenceservices.serving.kubeflow.org notebooks.kubeflow.org poddefaults.kubeflow.org pytorchjobs.kubeflow.org scheduledworkflows.kubeflow.org suggestions.kubeflow.org tfjobs.kubeflow.org trials.kubeflow.org
  kubectl delete apiservices v1.kubeflow.org v1alpha1.kubeflow.org v1alpha2.serving.kubeflow.org v1alpha3.kubeflow.org v1beta1.kubeflow.org
  kubectl delete validatingwebhookconfigurations inferenceservice.serving.kubeflow.org
  kubectl delete mutatingwebhookconfigurations inferenceservice.serving.kubeflow.org
  kubectl delete clusterroles knative-serving-admin knative-serving-core knative-serving-istio knative-serving-namespaced-admin
  kubectl delete clusterrolebindings knative-serving-controller-admin
  kubectl delete crd services.serving.knative.dev serverlessservices.networking.internal.knative.dev routes.serving.knative.dev revisions.serving.knative.dev podautoscalers.autoscaling.internal.knative.dev metrics.autoscaling.internal.knative.dev ingresses.networking.internal.knative.dev images.caching.internal.knative.dev configurations.serving.knative.dev clusteringresses.networking.internal.knative.dev certificates.networking.internal.knative.dev
  kubectl delete apiservices v1alpha1.autoscaling.internal.knative.dev v1alpha1.caching.internal.knative.dev v1alpha1.networking.internal.knative.dev v1alpha1.serving.knative.dev v1beta1.custom.metrics.k8s.io
  kubectl delete clusterroles istio-citadel-istio-system istio-cleanup-secrets-istio-system istio-egressgateway-istio-system istio-galley-istio-system istio-grafana-post-install-istio-system istio-ingressgateway-istio-system istio-mixer-istio-system istio-pilot-istio-system istio-reader istio-security-post-install-istio-system istio-sidecar-injector-istio-system prometheus-istio-system
  kubectl delete clusterrolebindings istio-citadel-istio-system istio-egressgateway-istio-system istio-cleanup-secrets-istio-system istio-galley-admin-role-binding-istio-system istio-grafana-post-install-role-binding-istio-system istio-ingressgateway-istio-system istio-kiali-admin-role-binding-istio-system istio-mixer-admin-role-binding-istio-system istio-multi istio-pilot-istio-system istio-security-post-install-role-binding-istio-system istio-sidecar-injector-admin-role-binding-istio-system prometheus-istio-system
  kubectl delete apiservices v1alpha1.authentication.istio.io v1alpha1.rbac.istio.io v1alpha2.config.istio.io v1alpha3.networking.istio.io
  kubectl delete crd zipkins.config.istio.io virtualservices.networking.istio.io tracespans.config.istio.io templates.config.istio.io stdios.config.istio.io statsds.config.istio.io stackdrivers.config.istio.io solarwindses.config.istio.io signalfxs.config.istio.io sidecars.networking.istio.io serviceroles.rbac.istio.io servicerolebindings.rbac.istio.io serviceentries.networking.istio.io rules.config.istio.io reportnothings.config.istio.io redisquotas.config.istio.io rbacs.config.istio.io rbacconfigs.rbac.istio.io quotaspecs.config.istio.io quotaspecbindings.config.istio.io quotas.config.istio.io prometheuses.config.istio.io
  kubectl delete crd policies.authentication.istio.io opas.config.istio.io noops.config.istio.io metrics.config.istio.io meshpolicies.authentication.istio.io memquotas.config.istio.io logentries.config.istio.io listentries.config.istio.io listcheckers.config.istio.io kuberneteses.config.istio.io kubernetesenvs.config.istio.io instances.config.istio.io httpapispecs.config.istio.io httpapispecbindings.config.istio.io handlers.config.istio.io gateways.networking.istio.io fluentds.config.istio.io envoyfilters.networking.istio.io edges.config.istio.io dogstatsds.config.istio.io destinationrules.networking.istio.io deniers.config.istio.io clusterrbacconfigs.rbac.istio.io
  kubectl delete crd cloudwatches.config.istio.io circonuses.config.istio.io checknothings.config.istio.io bypasses.config.istio.io authorizations.config.istio.io attributemanifests.config.istio.io apikeys.config.istio.io adapters.config.istio.io
  kubectl delete mutatingwebhookconfigurations istio-sidecar-injector
  kubectl delete apiservices v1beta1.kubeflow.org
  kubectl delete MutatingWebhookConfiguration webhook.serving.knative.dev istio-sidecar-injector katib-mutating-webhook-config inferenceservice.serving.kubeflow.org
  kubectl delete crd certificates.certmanager.k8s.io challenges.certmanager.k8s.io clusterissuers.certmanager.k8s.io issuers.certmanager.k8s.io orders.certmanager.k8s.io compositecontrollers.metacontroller.k8s.io controllerrevisions.metacontroller.k8s.io decoratorcontrollers.metacontroller.k8s.io workflows.argoproj.io
  kubectl delete clusterrole kiali kiali-viewer application-controller-cluster-role argo argo-ui centraldashboard admission-webhook-bootstrap-cluster-role jupyter-web-app-cluster-role notebook-controller-role pytorch-operator custom-metrics-server-resources knative-serving-admin knative-serving-core knative-serving-istio knative-serving-namespaced-admin kfserving-proxy-role spartakus tf-job-operator katib-controller katib-ui kubeflow-katib-admin kubeflow-katib-edit kubeflow-katib-view ml-pipeline-persistenceagent pipeline-runner ml-pipeline-viewer-controller-role seldon-operator-manager-role
  kubectl delete clusterrolebinding application-controller-cluster-role-binding meta-controller-cluster-role-binding argo argo-ui centraldashboard admission-webhook-bootstrap-cluster-role-binding admission-webhook-cluster-role-binding jupyter-web-app-cluster-role-binding notebook-controller-role-binding pytorch-operator custom-metrics:system:auth-delegator hpa-controller-custom-metrics kfserving-proxy-rolebinding spartakus tf-job-operator katib-controller katib-ui ml-pipeline-persistenceagent pipeline-runner ml-pipeline-viewer-crd-role-binding ml-pipeline-scheduledworkflow profiles-cluster-role-binding seldon-operator-manager-rolebinding
  kubectl delete crd profiles.kubeflow.org &
  kubectl patch crd/profiles.kubeflow.org -p '{"metadata":{"finalizers":[]}}' --type=merge
  kubectl delete customresourcedefinitions viewers.kubeflow.org
}

clean_other_ns(){
  kubectl delete ns istio-system &
  kubectl delete ns knative-serving &
  kubectl delete ns kfserving-system &
  sleep 20s
  ns_list=$(kubectl get namespace | grep "Terminating" | awk '{print $1}')

  if [ ${#ns_list} -eq 0 ];then
    echo "[INFO] clean namespace"
    exit 0
  else
    for ns in ${ns_list};do
      kubectl proxy &
      sleep 5s
      kubectl get namespace ${ns} -o json |jq '.spec = {"finalizers":[]}' > temp.json
      curl -k -H "Content-Type: application/json" -X PUT --data-binary @temp.json 127.0.0.1:8001/api/v1/namespaces/$NAMESPACE/finalize
      rm temp.json && kill %1
      echo "clean namespace : $ns"
    done
  fi
}

main(){
  clean_using_kfctl
  clean_no_ns
  clean_other_ns
}

main
