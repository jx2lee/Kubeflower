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

### Set Config
In folder, You must set the config `kubeflow.config`  
```bash
$ cat kubeflow.config
docker_registry= #private docker registry address, ex)192.168.179.185:5000
KF_NAME=my-kubeflow #default, can be modified.
```

## (optional) Push image needed to install kubeflow
Push the image tar needed for Kubeflow installation in the private docker registry. check the contents of [https://github.com/jx2lee/kubeflow-image-loader](https://github.com/jx2lee/kubeflow-image-loader).

## Install Kubeflow
Follow the steps below to use `installer.sh`

### Build
```bash
$ ./installer.sh build
```
Then, Check the folder `${KF_NAME}`.  
```bash
$ ls -alF ./my_kubeflow
-rwxr-xr-x  1 root root 6678 Jun 27 17:03 kfctl_k8s_istio.0.7.1.yaml*
drwxr-xr-x 39 root root 4096 Jun 27 17:04 kustomize/
```

### Deploy
```bash
$ ./installer.sh deploy
```

## Delete Kubeflow

To delete Kubeflow, use `installer.sh`.  
```bash
$ ./installer.sh remove
```

- After executing the command, check if all resources in the namespace have been deleted.  
```bash
$ kubectl get all -n kubeflow
No resources found.
```

## History

**ver0.2**  
- Add Image for kfserving-system
- Add `my-kubeflow/kustomize/kfserving-0.2.2.yaml`
- Modify `kustomize/argo/base/params.env`
- Modify `utils/clean-kubeflow.sh`

**ver0.3**  
- Add folder `lib`/`template`/`utils`
- `installer.sh`
  - `build`: make yaml using `kubeflow.config`
    - `kubeflow.config`
      - docker_registry: private registry
      - KF_NAME: kubeflow name *(Can be modified)*
  - `deploy`: install kubeflow
  - `remove`: uninstall kubeflow


---
made by *jaejun.lee*