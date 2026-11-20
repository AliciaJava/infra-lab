# 🧪 infra-lab

**Laboratorio personal de infraestructura, virtualización y automatización.**

> 🖥️ **Equipo actual:** Ubuntu 24 · 12 GB de RAM · SSD de 256 GB
> 🧭 **Enfoque:** Probar y documentar, no es un entorno de producción.

## Objetivos

- Administrar el host Linux y sus máquinas virtuales.
- Automatizar tareas repetibles con Ansible.
- Practicar virtualización con KVM y libvirt.
- Aprender redes y almacenamiento mediante ejercicios pequeños.
- Documentar decisiones, comandos y resultados para poder repetirlos.

## VMs

| Nombre | SO | RAM | vCPUs | Disco |
|--------|-----|-----|-------|-------|
| ubuntu-24.04 | Ubuntu 24.04 LTS | 4G | 2 | 20G |

## Uso rápido

Ver [runbook de creación de VMs](docs/runbooks/create-vm.md).

| Acción | Comando |
|--------|---------|
| Crear VM | `sudo virt-install --name <nombre> --ram 4096 --vcpus 2 ...` |
| Ver IP | `sudo virsh domifaddr <nombre>` |
| Conectar | `ssh aliciaserver@<ip>` |

## Ansible

Ver [runbook de Ansible](docs/runbooks/ansible-setup.md).

| Acción | Comando |
|--------|---------|
| Probar conexión | `ansible -i ~/infra-lab/ansible/inventories/hosts.yml all -m ping` |
| Ejecutar playbook | `ansible-playbook -i ~/infra-lab/ansible/inventories/hosts.yml ~/infra-lab/ansible/playbooks/setup.yml` | 
 

## Estado (2026-11-20)

- VM `ubuntu-24.04` creada con cloud image + cloud-init
- IP: asignada por DHCP en la red NAT de libvirt
- Usuario: aliciaserver
- SSH operativo
- Kernel: 6.8.0-151-generic
- Ansible instalado en el host
- Nginx desplegado en la VM vía playbook

## Hardware y decisiones técnicas

| Recurso | Situación actual | Decisión |
| --- | --- | --- |
| Memoria | 12 GB de RAM | Limitar VMs a 6–7 GB conjuntos |
| Almacenamiento | SSD de 256 GB | Discos dinámicos, control de espacio |
| CPU | Pendiente de documentar | Comprobar virtualización antes de cargar |
| Red física | Pendiente de documentar | NAT de libvirt; bridge/VLAN solo con necesidad |

## Decisiones

- **Cloud-init + cloud image** para crear VMs (reproducible, sin instalador interactivo).
- **NAT al principio:** conectividad sin tocar la red física.
- **VLAN, bonding, Ceph, OpenStack:** aplazados hasta tener nodos o caso de uso claro.
- **No guardar imágenes de VM ni secretos en Git.**

## Estructura del repositorio

- `ansible/`: inventarios, playbooks y roles.
- `libvirt/`: redes, VMs y cloud-init.
- `networking/`: VLAN, bonding, iptables.
- `storage/`: Ceph, iSCSI, NFS.
- `orchestration/`: CloudStack, OpenStack.
- `docs/`: runbooks, decisiones y apuntes.

## Progreso

- [x] Preparar el host para KVM/libvirt
- [x] Crear la primera VM (cloud-init)
- [x] SSH operativo en la VM
- [x] Ansible instalado y primer playbook (nginx)
- [ ] Documentar CPU y red física
- [ ] Segunda VM / multi-nodo
- [ ] Red aislada o bridge
- [ ] Ampliar el laboratorio   
