# Kubeflow installation-closed network (Ver0.7.1)
This is repo How to install Kubeflow in a Kubernetes cluster environment (closed network).

## Check Kubernetes environment before installation
Before installing Kubeflow, check your Kubernetes environment.

### Cluster node status
Check the status of the K8s cluster node as STATUS with the command `$ kubectl get nodes`.
  
| NAME | ROLES | STATUS | VERSION | OS | KERNEL-VERSION | CONTAINER-RUNTIME |
| ---------- | ------ | ------ | ------- | ------------------ | ----------------- | ----------------- |
| k8s-master | master | Ready | v1.15.3 | Ubuntu 18.04.3 LTS | 4.15.0-74-generic | docker: //19.3.5 |
| k8s-node1 | master | Ready | v1.15.3 | Ubuntu 18.04.3 LTS | 4.15.0-76-generic | docker: //19.3.5 |
| k8s-node2 | master | Ready | v1.15.3 | Ubuntu 18.04.3 LTS | 4.15.0-76-generic | docker: //19.3.5 |
| k8s-node3 | worker | Ready | v1.15.3 | Ubuntu 18.04.3 LTS | 4.15.0-76-generic | docker: //19.3.5 |
| k8s-node4 | worker | Ready | v1.15.3 | Ubuntu 18.04.3 LTS | 4.15.0-76-generic | docker: //19.3.5 |

### Storage class default setting
When entering the `$ kubectl get storageclass` or `$ kubectl get sc` command, check the `(default)` display in the NAME column.  
Storageclass exists, but if there is no "(default)" mark, define the default storage class with the following command.  
```bash
$ kubectl patch storageclass {Storage class name} -p '{"metadata":{"annotations":{"storageclass.kubernetes.iis-default-class":"true"}}}'
$ kubectl get storageclass
NAME PROVISIONER AGE
csi-cephfs-sc rook-ceph.cephfs.csi.ceph.com 6d18h
rook-ceph-block (default) rook-ceph.rbd.csi.ceph.com 6d18h
```

## Kubeflow preferences
Follow the steps below to move the Kubeflow CLI (kfctl) and set environment variables.

### Move the kfctl executable from the unzipped folder to /usr/bin.
```bash
$ tar -xvzf kfctl.tar.gz
$ cp kfctl /usr/bin
```
### Set environment variables in the configuration files (`.bashrc, .bash_profile, .profile`) that exist for each user account of the operating system. In this document, environment variables are set as follows.

```bash
$ vi ~ /.bashrc
# .bashrc
export KF_NAME=my-kubeflow #Can be modified.
export BASE_DIR=/root/kubeflow #Can be modified
export KF_DIR=${BASE_DIR}/${KF_NAME}
export CONFIG_FILE=${KF_DIR}/kfctl_k8s_istio.0.7.1.yaml
```
> *(Note)*
> * `KF_NAME`: Name of the Kubeflow deployment, specifying a custom deployment name.
> * `BASE_DIR`: Path to the extracted Kubeflow directory.
> * `KF_DIR`: Full path to Kubeflow application directory.
> * `CONFIG_FILE`: Configuration YAML file to be used to deploy Kubeflow.

## (optional) Push image needed to install kubeflow
Push the image tar needed for Kubeflow installation in the private docker registry. Access the `imageLoader` executable file in` $BASE_DIR/images/imageLoader` and add a registry.  

> Note: **When executing the push command, there must be no image with the image tag `<none>` through docker images.**
```bash
$ cd $BASE_DIR/images/imageLoader
$ vi imageLoader
$ tar -xvf images.tar
#registry={registry_ip}:{registry_port}
$ ./imageLoader push
```
> *For more information, check the contents of [https://github.com/jx2lee/kubeflow-image-loader](https://github.com/jx2lee/kubeflow-image-loader).*

## Kubeflow deployment
Follow the steps below to modify and deploy the YAML file in $KF_DIR(`/root/kubeflow/my-kubeflow`).

### kfctl_k8s_istio.0.7.1.yaml file fix
Access to vim and change the `uri: {BASE_DIR}` part to path with the `$ echo $BASE_DIR` command.  
```bash
$ vi my-kubeflow/kfctl_k8s_istio.0.7.1.yaml
#kfctl_k8s_istio.0.7.1.yaml
...
...
-name: manifests
  #uri: https://github.com/kubeflow/manifests/archive/v0.7-branch.tar.gz
  uri: $ {BASE_DIR}/v0.7-branch.tar.gz # modify {BASE_DIR}
version: v0.7.1
```

### Use the sed.sh script in the `$KF_DIR/kustomize` folder to change the image name required for installation.
```bash
$ ./sed.sh {registry IP}:{registry Port}
```

### Kubeflow distribution using kfctl
`$ kfctl apply -V -f ${CONFIG_FILE}`
  
## Confirm Kubeflow startup
### `http://{NODE_IP}:31380` After connecting, check if Namespaces creation screen appears.
If the Namespace creation screen does not appear, delete the `.cache` folder in the `${KF_DIR}`directory and reinstall it with the command `$ kfctl apply -V -f ${CONFIG_FILE}`.

## Delete Kubeflow

To delete Kubeflow, use the `kfctl delete` command below.  
```bash
$ cd ${KF_DIR}
$ kfctl delete -f ${CONFIG_FILE}
```

- After executing the command, check if all resources in the namespace have been deleted.  
```bash
$ kubectl get all -n kubeflow
No resources found.
```

- Delete all installed Kubeflow related resources using the clean-kubeflow.sh executable file in` ${BASE_DIR}/utils`.
```bash
$ ./clean-kubeflow.sh
```

## History

**ver0.2**  
- Add Image for kfserving-system
- Add `my-kubeflow/kustomize/kfserving-0.2.2.yaml`
- Modify `kustomize/argo/base/params.env`
- Modify `utils/clean-kubeflow.sh`


---
made by *jaejun.lee*
