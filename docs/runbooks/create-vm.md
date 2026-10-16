# Runbook: Crear y instalar VM Ubuntu Server

## 1. Descargar ISO

cd ~/Descargas
wget -c https://releases.ubuntu.com/resolute/ubuntu-26.04.1-live-server-amd64.iso
wget -c https://releases.ubuntu.com/resolute/SHA256SUMS
sha256sum -c SHA256SUMS --ignore-missing

## 2. Copiar al pool de libvirt

sudo cp ~/Descargas/ubuntu-26.04.1-live-server-amd64.iso /var/lib/libvirt/images/

## 3. Crear la VM

ISO=/var/lib/libvirt/images/ubuntu-26.04.1-live-server-amd64.iso scripts/create-vm.sh ubuntu-26.04 4096 2 20

## 4. Conectar VNC

gvncviewer localhost:0

## 5. Instalador (Subiquity)

- Idioma: Español
- Teclado: Español (es)
- Red: Default (NAT)
- Nombre: ubuntu-26.04
- Usuario: alicia
- Particionado: Usar disco completo
- SSH: Instalar OpenSSH

## 6. Post-instalacion

sudo virsh reboot ubuntu-26.04
sudo virsh domifaddr ubuntu-26.04
ssh alicia@192.168.122.x   
