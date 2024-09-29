# Has to run on a host which is avaiablie to proxmox/init VM and vice versa
# maybe format has to be changed in the packer.json
# source ./myscript.sh
sudo apt install git curl make pipx jq unzip packer -y 
pipx install --include-deps ansible
pipx ensurepath
git clone https://github.com/kubernetes-sigs/image-builder.git
export PROXMOX_URL=https://192.168.2.142:8006/api2/json
export PROXMOX_USERNAME=root@pam!builder
export PROXMOX_TOKEN=
export PROXMOX_NODE=node01
export PROXMOX_ISO_POOL=local
export PROXMOX_BRIDGE=vmbr0
export PROXMOX_STORAGE_POOL=nvmethinpool
# Kubernetes Series has to be the minor version
export PACKER_FLAGS="--var 'kubernetes_rpm_version=1.31.1' --var 'kubernetes_semver=v1.31.1' --var 'kubernetes_series=v1.31' --var 'kubernetes_deb_version=1.31.1-1.1'"
cd ./image-builder/images/capi
make deps-proxmox
make build-proxmox-ubuntu-2404
cd ../../..


# create backup of the vm
# export the backup via scp or whatever
# add it to release