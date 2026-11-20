# Redes libvirt

## default (NAT)

| Propiedad | Valor |
|-----------|-------|
| Bridge | virbr0 |
| Subred | 192.168.122.0/24 |
| Gateway | 192.168.122.1 |
| DHCP | 192.168.122.2 – 192.168.122.254 |
| NAT | Sí (masquerade) |

### Comandos

    sudo virsh net-info default
    sudo virsh net-dhcp-leases default
    sudo virsh net-define <archivo.xml>  # para crear redes nuevas   
