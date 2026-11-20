# Hardware del host

## CPU

| Propiedad | Valor |
|-----------|-------|
| Modelo | Intel Core i5-5300U @ 2.30 GHz |
| Generación | Broadwell (5ª gen) |
| Núcleos / Threads | 2 / 4 |
| Virtualización | VT-x (soportado) |
| TDP | 15W (laptop) |

## RAM

- 12 GB total
- Margen para host: ~5 GB
- Máximo para VMs: ~6-7 GB conjuntos

## Almacenamiento

- SSD 256 GB
- Usar discos dinámicos (qcow2) para no ocupar espacio hasta que se escriba

## Red

| Interface | Tipo | Estado | Nota |
|-----------|------|--------|------|
| wlp3s0 | WiFi | UP | Red física (192.168.1.81/24) |
| enp0s25 | Ethernet | DOWN | Necesaria para bonding/VLAN |
| virbr0 | Bridge (libvirt) | UP | NAT 192.168.122.0/24 |

## Limitaciones

- **WiFi como red física:** suficiente para SSH y uso básico. Para pruebas de red (bonding, VLAN) se necesita Ethernet.
- **CPU de laptop:** no apta para cargas sostenidas pesadas. 2 VMs con 2 vCPUs cada una es el límite práctico.
- **SSD 256 GB:** controlar el tamaño de discos virtuales y cloud images.   
