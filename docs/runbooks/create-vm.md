# Runbook: Crear VM Ubuntu con cloud-init

## 1. Descargar cloud image

    cd ~/Descargas
    wget -c https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img
    sudo cp noble-server-cloudimg-amd64.img /var/lib/libvirt/images/

## 2. Crear user-data

Archivo: `virtualization/kvm/cloud-init/<nombre>-user-data.yaml`

    #cloud-config
    users:
      - name: aliciaserver
        sudo: ALL=(ALL) NOPASSWD:ALL
        ssh_authorized_keys:
          - <clave_publica>
    packages:
      - openssh-server
      - qemu-guest-agent
    runcmd:
      - systemctl enable --now ssh
      - systemctl enable --now qemu-guest-agent

## 3. Crear la VM

    sudo virt-install \
      --name <nombre> \
      --ram 4096 \
      --vcpus 2 \
      --disk path=/var/lib/libvirt/images/<nombre>.qcow2,size=20,backing_store=/var/lib/libvirt/images/noble-server-cloudimg-amd64.img \
      --cloud-init user-data="$HOME/infra-lab/virtualization/kvm/cloud-init/<nombre>-user-data.yaml" \
      --os-variant ubuntu24.04 \
      --network network=default \
      --graphics vnc,listen=0.0.0.0 \
      --noautoconsole

## 4. Conectar

    sleep 15
    sudo virsh domifaddr <nombre>
    ssh aliciaserver@<ip>

## Notas

- La VM arranca en ~10s con SSH ya activo. No requiere VNC ni consola.
- Si la IP no aparece a los 15s, espera más (cloud-init tarda al primer arranque).
- Alternativa para ver la IP: `sudo virsh net-dhcp-leases default`   

  
