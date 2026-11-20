# Runbook: LXD en el host

## 1. Instalar

    sudo snap install lxd

## 2. Añadir usuario al grupo

    sudo usermod -aG lxd $USER
    # Cerrar sesión y volver a entrar (o: newgrp lxd)

## 3. Inicializar

    lxd init --auto

## 4. Crear contenedor

    lxc launch ubuntu:24.04 <nombre>

## 5. Verificar

    lxc list
    lxc exec <nombre> -- hostname
    lxc exec <nombre> -- ip -brief addr show

## 6. Conectar por SSH (opcional)

    lxc exec <nombre> -- sudo apt install -y openssh-server
    lxc exec <nombre> -- sudo systemctl enable --now ssh
    ssh <usuario>@<ip>

## Red

- Bridge: `lxdbr0`
- IPv4: 10.161.116.0/24 (NAT)
- IPv6: ULA (fd42:...)   
