# 🧪 infra-lab

**Laboratorio personal de infraestructura, virtualización y automatización.**

Este repositorio documenta y versiona las prácticas del laboratorio. La prioridad es avanzar de forma gradual: primero un host sencillo y estable; después, máquinas virtuales y servicios aislados; finalmente, prácticas que necesiten varios nodos.

> 🖥️ **Equipo actual:** Ubuntu 24 · 12 GB de RAM · SSD de 256 GB  
> 🧭 **Enfoque:** Probar y documentar, no es un entorno de producción.

## Objetivos

- Administrar el host Linux y sus máquinas virtuales.
- Automatizar tareas repetibles con Ansible.
- Practicar virtualización con KVM y libvirt.
- Aprender redes y almacenamiento mediante ejercicios pequeños.
- Documentar decisiones, comandos y resultados para poder repetirlos.

## Hardware y decisiones técnicas

| Recurso | Situación actual | Decisión para el laboratorio |
| --- | --- | --- |
| Memoria | 12 GB de RAM | Mantener margen para Ubuntu. Empezar con una o dos VMs ligeras y limitar su memoria conjunta a unos 6–7 GB como referencia inicial. |
| Almacenamiento | SSD de 256 GB | Controlar el espacio de discos virtuales e imágenes. Usar discos de tamaño dinámico cuando corresponda y dejar espacio libre para el sistema. |
| CPU | Pendiente de documentar | Comprobar modelo, núcleos y soporte de virtualización antes de planificar cargas mayores. |
| Red física | Pendiente de documentar | Empezar con la red NAT predeterminada de libvirt. Crear puentes o VLAN solo cuando haya una necesidad concreta. |

Las cifras anteriores son un punto de partida, no una garantía de rendimiento. Se revisarán según el uso real del host y de las VMs.

## Qué se ejecuta en cada sitio

### En el host Ubuntu

- Git y este repositorio.
- Ansible para automatizar tareas del laboratorio.
- KVM/libvirt para administrar máquinas virtuales.
- Herramientas de diagnóstico y documentación.

### Dentro de máquinas virtuales

- Servicios y sistemas que se quieran probar de forma aislada.
- Ejercicios de Ansible contra otros equipos.
- Prácticas que puedan modificar configuraciones sin afectar directamente al host.

### En nodos futuros

Las prácticas que necesiten varias máquinas por ejemplo, clústeres, alta disponibilidad o pruebas realistas de almacenamiento distribuido— se dejarán para cuando haya nodos adicionales disponibles.

## Decisiones y límites actuales

- **Empezar por libvirt y VMs pequeñas:** permite aprender virtualización sin desplegar desde el primer día una plataforma completa.
- **Usar NAT al principio:** es una opción sencilla para que las VMs tengan conectividad sin cambiar la configuración de la red física.
- **Dejar VLAN y bonding para más adelante:** se añadirán cuando haya un caso de uso claro; bonding requiere varias interfaces físicas.
- **Aplazar Ceph y OpenStack como despliegues de varios nodos:** con un solo host y 12 GB de RAM, no son el primer objetivo práctico. Se pueden estudiar más adelante, con expectativas y recursos adecuados.
- **No guardar imágenes de VM ni secretos en Git:** el repositorio contiene configuraciones y documentación, no discos virtuales, claves privadas, contraseñas o tokens.

## Estructura del repositorio

- `ansible/`: inventarios, playbooks y roles.
- `libvirt/`: redes, máquinas virtuales y archivos de cloud-init.
- `networking/`: prácticas de VLAN, bonding e iptables.
- `storage/`: documentación y pruebas de almacenamiento.
- `orchestration/`: notas y pruebas futuras con plataformas de orquestación.
- `docs/`: procedimientos, decisiones y apuntes.

## Progreso

- [ ] Preparar el host para KVM/libvirt.
- [ ] Crear la primera máquina virtual.
- [ ] Automatizar una tarea sencilla con Ansible.
- [ ] Documentar la red y el almacenamiento disponibles.
- [ ] Ampliar el laboratorio cuando haya nuevos requisitos o nodos.

---

*Laboratorio continua en evolución. Las decisiones se revisan cuando se mejore el hardware.*

# infra-lab

Lab de infraestructura local con KVM/libvirt.

## VMs

| Nombre | SO | RAM | vCPUs | Disco |
|--------|-----|-----|-------|-------|
| ubuntu-26.04 | Ubuntu 26.04 | 4G | 2 | 20G |

## Uso rapido

ISO=/var/lib/libvirt/images/ubuntu-26.04.1-live-server-amd64.iso scripts/create-vm.sh ubuntu-26.04 4096 2 20

gvncviewer localhost:0

sudo virsh domifaddr ubuntu-26.04   
