# Runbook: Ansible en el host

## 1. Instalar Ansible

    sudo apt install -y ansible

## 2. Inventario

Archivo: `automation/ansible/inventories/hosts.yml`

    all:
      hosts:
        ubuntu-24.04:
          ansible_host: <ip>
          ansible_user: aliciaserver
          ansible_ssh_private_key_file: ~/.ssh/id_ed25519

## 3. Playbook

Archivo: `automation/ansible/playbooks/setup.yml`

Instala `curl`, `nginx` y `htop` en la VM.

## 4. Probar conexión

    ansible -i ~/infra-lab/automation/ansible/inventories/hosts.yml all -m ping

## 5. Ejecutar playbook

    ansible-playbook -i ~/infra-lab/automation/ansible/inventories/hosts.yml ~/infra-lab/automation/ansible/playbooks/setup.yml

## 6. Verificar

    curl http://<ip>   
