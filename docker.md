- Deploy a local Docker registry to push and pull images from - https://docs.docker.com/registry/deploying/
- Run an insecure registry with either no authentication or with self-signed certificates - https://docs.docker.com/registry/insecure/
  - make sure you use `subjectAltName` while creating the keys via the `openssl` command, see https://stackoverflow.com/a/65711669/2361720 to not get the SAN error
  - Once everything is done, add the certificate to the trusted store, see [pki.md](pki.md)
  - To make OpenShift pull images from this registry, run these commands from here - https://www.ibm.com/support/knowledgecenter/SSFC4F_2.1.0/icam/ts_cloud_native_monitoring_imagepullbackoff.html
```
scp <your-registry-server>:/opt/registry/certs/domain.crt <path>/ca.crt
oc create configmap registry-config --from-file=<your_docker_registry_host>..<your_docker_registry_port>=<path>/ca.crt -n openshift-config
oc patch image.config.openshift.io/cluster --patch '{"spec":{"additionalTrustedCA":{"name":"registry-config"}}}' --type=merge
```
