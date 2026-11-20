# Runbook: Ansible en el host

## 1. Instalar Ansible

    sudo apt install -y ansible

## 2. Inventario

Archivo: `ansible/inventories/hosts.yml`

    all:
      hosts:
        ubuntu-24.04:
          ansible_host: <ip>
          ansible_user: aliciaserver
          ansible_ssh_private_key_file: ~/.ssh/id_ed25519

## 3. Playbook

Archivo: `ansible/playbooks/setup.yml`

Instala `curl`, `nginx` y `htop` en la VM.

## 4. Probar conexión

    ansible -i ~/infra-lab/ansible/inventories/hosts.yml all -m ping

## 5. Ejecutar playbook

    ansible-playbook -i ~/infra-lab/ansible/inventories/hosts.yml ~/infra-lab/ansible/playbooks/setup.yml

## 6. Verificar

    curl http://<ip>   

## Ansible

- **Inventario:** `ansible/inventories/hosts.yml`
- **Playbooks:** `ansible/playbooks/`
- **Runbook:** `docs/runbooks/ansible-setup.md`

### Comandos

    ansible -i ~/infra-lab/ansible/inventories/hosts.yml all -m ping
    ansible-playbook -i ~/infra-lab/ansible/inventories/hosts.yml ~/infra-lab/ansible/playbooks/setup.yml   


- [x] Ansible instalado en el host
- [x] Nginx desplegado en la VM vía playbook   

