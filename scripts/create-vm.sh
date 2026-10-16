#!/usr/bin/env bash
set -euo pipefail

NAME="${1:?Uso: $0 <nombre> [RAM] [vCPUs] [SIZE_GB]}"
RAM="${2:-4096}"
VCPUS="${3:-2}"
SIZE="${4:-20}"
ISO="${ISO:?Define ISO=/ruta/a/la/iso}"
OSVARIANT="${OSVARIANT:-ubuntu24.04}"

sudo virt-install \
  --name "$NAME" \
  --ram "$RAM" \
  --vcpus "$VCPUS" \
  --disk path=/var/lib/libvirt/images/${NAME}.qcow2,size=${SIZE} \
  --cdrom "$ISO" \
  --os-variant "$OSVARIANT" \
  --network network=default \
  --graphics vnc,listen=0.0.0.0 \
  --noautoconsole

DISPLAY_NUM=$(sudo virsh vncdisplay "$NAME" | tr -d ':')
echo ""
echo "✅ VM '$NAME' creada."
echo "🖥  VNC:  gvncviewer localhost:${DISPLAY_NUM}"
echo "🔌 IP:   sudo virsh domifaddr $NAME"
