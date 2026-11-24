# QEMU: Consola gráfica no funcional bajo Wayland

## Problema

La consola gráfica de QEMU (SDL/SPICE) no se renderiza al iniciar la VM
en Ubuntu 24.04. La ventana no aparece, queda congelada o lanza:

```
qemu-system-x86_64: -display spice: SPICE support is disabled
```

## Causa raíz

Ubuntu 24.04 utiliza **Wayland** como display server por defecto. QEMU
exige un backend de display (SDL, GTK, SPICE o VNC) para exponer la
salida VGA del guest. Bajo Wayland:

1. **SDL2 tiene soporte experimental para Wayland** con bugs conocidos
   de escalado y detección de resolución.
2. **El backend SPICE** no está disponible si `qemu-system-modules-spice`
   no está instalado o no tiene compositor compatible.

Resultado: no hay un backend de display fiable y la consola queda
inutilizable.

## Solución

Utilizar el **VNC server integrado de QEMU** (`-vnc`), que opera mediante
el protocolo RFB y **no depende del display server del host**. Funciona
bajo Wayland, X11 o en sesiones headless (SSH):

```bash
qemu-system-x86_64 \
  -enable-kvm \
  -m 4096 \
  -smp 2 \
  -drive file=vm.qcow2,format=qcow2,if=virtio \
  -netdev user,id=net0 \
  -device virtio-net-pci,netdev=net0 \
  -vnc :0 \
  -daemonize \
  -pidfile /tmp/vm.pid
```

Conexión:

```bash
# tigervnc-viewer
vncviewer localhost:0

# o virt-viewer (libvirt)
virt-viewer --connect qemu:///system <nombre-vm>
```

> `localhost:0` → `127.0.0.1:5900`. El display `:N` mapea al puerto `5900+N`.

## Verificación

```bash
ss -tlnp | grep 5900
# LISTEN 0 1 127.0.0.1:5900 0.0.0.0:* users:(("qemu-system-x86",pid=XXXX,fd=XX))
```

## Referencias

- [QEMU Documentation — VNC](https://www.qemu.org/docs/master/system/invocation.html)
- [QEMU Issue #2048 — SDL under Wayland](https://gitlab.com/qemu-project/qemu/-/issues/2048)
- [SDL Issue #11603 — Wayland video driver](https://github.com/libsdl-org/SDL/issues/11603)
- [ArchWiki — QEMU / VNC](https://wiki.archlinux.org/title/QEMU#VNC)   
