# Decisiones técnicas

## Virtualización: KVM + cloud-init (no ISO)

| Opción | Decisión | Motivo |
|--------|----------|--------|
| ISO completo + instalador interactivo | ❌ Descartada | No reproducible. La primera VM (`ubuntu-26.04`) quedó colgada en el instalador. |
| Cloud image + cloud-init | ✅ Elegida | Arranque en ~10s, SSH automático, reproducible con un comando. |

## Contenedores: Docker (no Podman)

| Opción | Decisión | Motivo |
|--------|----------|--------|
| Docker + Compose | ✅ Elegida | Ecosistema más amplio, `docker compose` nativo, más documentación. |
| Podman | ❌ Descartada | Da el mismo resultado. No hay motivo para mantener ambos. |

## Contenedores de sistema: LXD

| Opción | Decisión | Motivo |
|--------|----------|--------|
| LXD (snap) | ✅ Elegida | Contenedores de sistema con kernel compartido. Arranque en 1-2s, ideal para pruebas con 12 GB RAM. |
| Segunda VM KVM para cada servicio | ❌ No | Consume 4 GB RAM por VM. Con 12 GB totales, 2 VMs ya son el límite. |

## Red: NAT de libvirt (no bridge)

| Opción | Decisión | Motivo |
|--------|----------|--------|
| NAT (`virbr0`, 192.168.122.0/24) | ✅ Elegida | Funciona sin tocar la red física. Suficiente para SSH y servicios internos. |
| Bridge (`br0`) | ❌ Aplazada | Requiere Ethernet. El host va por WiFi (`wlp3s0`), no se puede hacer bridge. |

## Orquestación: aplazada

| Tecnología | Decisión | Motivo |
|------------|----------|--------|
| MicroCloud | ❌ Aplazada | Requiere 2-3 nodos mínimos. Con 1 host no tiene sentido. |
| OpenStack / CloudStack | ❌ Aplazada | Mismo motivo. Además consumen >8 GB RAM solo para el control plane. |
| Ceph | ❌ Aplazada | Necesita 3+ discos o nodos. Con 1 SSD de 256 GB no es viable. |

## Comparativa de tecnologías en este lab

| | KVM/QEMU | LXD | Docker |
|---|----------|-----|--------|
| **Aislamiento** | Kernel completo | Kernel compartido | Kernel compartido |
| **Arranque** | ~30s | ~2s | <1s |
| **RAM por unidad** | 4 GB (mínimo práctico) | ~200 MB | ~50 MB |
| **Uso en este lab** | VMs con SO completo | Servicios que necesitan Linux completo | Microservicios, pruebas rápidas |
| **Límite con 12 GB** | 2 VMs | 10-15 contenedores | 20+ contenedores |

## Regla general

> Con 12 GB RAM y 1 SSD: **KVM para lo que necesite SO completo, LXD para Linux completo ligero, Docker para aplicaciones.** No forzar tecnologías que necesiten más nodos o más RAM de la disponible.   
