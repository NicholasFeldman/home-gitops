terraform {
    cloud {
        organization = "nick03180a60"
        workspaces {
          name = "home-workspace"
        }
    }

    required_providers {
       proxmox = {
        source = "telmate/proxmox"
       }
    }
}

provider "proxmox" {
    pm_api_url = "https://10.10.90.50:8006/api2/json"
    pm_user = "terraform@pve"
    pm_password = "terraform"
    pm_tls_insecure = "true"
}

resource "proxmox_vm_qemu" "skywalker-control-plane-0" {
  name = "skywalker-control-plane-0"
  target_node = "kamino"
  scsihw = "virtio-scsi-single"
  full_clone                = false

  tags = "kubernetes"

  agent = 1
  boot = "order=scsi0;net0"
  cores = 10
  sockets = 2
  memory = 65536

  onboot = true
  define_connection_info = false

  disk {
    size               = "128G"
    storage            = "vmpool"
    type               = "scsi"
  }

  // Longhorn
  disk {
    size               = "128G"
    storage            = "local-zfs"
    type               = "scsi"
  }

  network {
    bridge = "vmbr0"
    firewall = true
    macaddr = "AA:BB:A3:FF:7C:D4"
    model = "virtio"
    mtu = 0
    queues = 0
  }
}

resource "proxmox_vm_qemu" "skywalker-worker-0" {
  name = "skywalker-worker-0"
  target_node = "naboo"
  scsihw = "virtio-scsi-single"
  full_clone                = false

  tags = "kubernetes"

  agent = 1
  boot = "order=scsi0;net0"
  cores = 4
  memory = 4096

  onboot = true
  define_connection_info = false

  disk {
    size               = "128G"
    storage            = "local-zfs"
    type               = "scsi"
  }

  // Longhorn
  disk {
    size               = "256G"
    storage            = "local-zfs"
    type               = "scsi"
  }

  network {
    bridge = "vmbr0"
    firewall = true
    macaddr = "AA:BB:8F:FD:69:E6"
    model = "virtio"
    mtu = 0
    queues = 0
  }

}

resource "proxmox_vm_qemu" "skywalker-worker-1" {
  name = "skywalker-worker-1"
  target_node = "alderaan"
  scsihw = "virtio-scsi-single"
  full_clone                = false

  tags = "kubernetes"

  agent = 1
  boot = "order=scsi0;net0"
  cores = 8
  memory = 4096

  onboot = true
  define_connection_info = false

  disk {
    size               = "128G"
    storage            = "local-zfs"
    type               = "scsi"
  }

  // Longhorn
  disk {
    size               = "256G"
    storage            = "local-zfs"
    type               = "scsi"
  }

  network {
    bridge = "vmbr0"
    firewall = true
    macaddr = "AA:BB:33:0B:29:8F"
    model = "virtio"
    mtu = 0
    queues = 0
  }
}
