# VMs del laboratorio

## ubuntu-24.04

| Propiedad | Valor |
|-----------|-------|
| SO | Ubuntu 24.04 LTS (cloud image) |
| RAM | 4096 MB |
| vCPUs | 2 |
| Disco | 20 GB (qcow2, backing store) |
| Red | default (NAT, 192.168.122.0/24) |
| Usuario | aliciaserver |
| SSH | Activo (clave ed25519) |
| Kernel | 6.8.0-151-generic |
| Servicios | nginx, htop, curl, qemu-guest-agent |

### Creación

Ver [runbook](../../docs/runbooks/create-vm.md).

### Comandos

    sudo virsh start ubuntu-24.04
    sudo virsh shutdown ubuntu-24.04
    sudo virsh domifaddr ubuntu-24.04
    ssh aliciaserver@<ip>   
