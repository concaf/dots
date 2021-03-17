- Access CRC running on a remote server - https://www.openshift.com/blog/accessing-codeready-containers-on-a-remote-server/

- To SSH into the CRC VM -
```
ssh -i ~/.crc/machines/crc/id_ecdsa core@`crc ip`
```

- By default, the monitoring operator is disabled. Run -
```
crc config set enable-cluster-monitoring true
```
to enable it. Also, the VM will need a minimum of 14GB of RAM when it is enabled.
