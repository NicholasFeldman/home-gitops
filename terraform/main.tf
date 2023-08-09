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
  full_clone = false
  qemu_os = "l26"
  scsihw = "virtio-scsi-single"

  tags = "kubernetes"

  agent = 1
  boot = "order=scsi0;net0"
  cores = 10
  sockets = 2
  memory = 65536

  onboot = true
  oncreate = false
  define_connection_info = false

  disk {
    backup = true
    cache = "none"
    file = "vm-300-disk-0"
    format = "raw"
    iops = 0
    iops_max = 0
    iops_max_length    = 0
    iops_rd            = 0
    iops_rd_max        = 0
    iops_rd_max_length = 0
    iops_wr            = 0
    iops_wr_max        = 0
    iops_wr_max_length = 0
    iothread           = 1
    mbps               = 0
    mbps_rd            = 0
    mbps_rd_max        = 0
    mbps_wr            = 0
    mbps_wr_max        = 0
    replicate          = 0
    size               = "64G"
    slot = 0
    ssd                = 0
    storage            = "vmpool"
    type               = "scsi"
    volume             = "vmpool:vm-300-disk-0"
  }

  disk {
    backup = true
    cache = "none"
    file = "vm-300-disk-0"
    format = "raw"
    iops = 0
    iops_max = 0
    iops_max_length    = 0
    iops_rd            = 0
    iops_rd_max        = 0
    iops_rd_max_length = 0
    iops_wr            = 0
    iops_wr_max        = 0
    iops_wr_max_length = 0
    iothread           = 1
    mbps               = 0
    mbps_rd            = 0
    mbps_rd_max        = 0
    mbps_wr            = 0
    mbps_wr_max        = 0
    replicate          = 0
    size               = "64G"
    slot               = 1
    ssd                = 0
    storage            = "local-zfs"
    type               = "scsi"
    volume             = "local-zfs:vm-300-disk-0"
  }

  network {
    bridge = "vmbr0"
    firewall = true
    link_down = false
    macaddr = "AA:BB:A3:FF:7C:D4"
    model = "virtio"
    mtu = 0
    queues = 0
    rate = 0
    tag = -1
  }
}

resource "proxmox_vm_qemu" "skywalker-worker-0" {
  name = "skywalker-worker-0"
  target_node = "naboo"
  full_clone = false
  qemu_os = "l26"
  scsihw = "virtio-scsi-single"

  tags = "kubernetes"

  agent = 1
  boot = "order=scsi0;net0"
  cores = 4
  memory = 4096

  onboot = true
  oncreate = false
  define_connection_info = false

  disk {
    backup = true
    cache = "none"
    file = "vm-310-disk-1"
    format = "raw"
    iops = 0
    iops_max = 0
    iops_max_length    = 0
    iops_rd            = 0
    iops_rd_max        = 0
    iops_rd_max_length = 0
    iops_wr            = 0
    iops_wr_max        = 0
    iops_wr_max_length = 0
    iothread           = 1
    mbps               = 0
    mbps_rd            = 0
    mbps_rd_max        = 0
    mbps_wr            = 0
    mbps_wr_max        = 0
    replicate          = 0
    size               = "64G"
    slot = 0
    ssd                = 0
    storage            = "local-zfs"
    type               = "scsi"
    volume             = "local-zfs:vm-310-disk-1"
  }

  disk {
    backup = true
    cache = "none"
    file = "vm-310-disk-0"
    format = "raw"
    iops = 0
    iops_max = 0
    iops_max_length    = 0
    iops_rd            = 0
    iops_rd_max        = 0
    iops_rd_max_length = 0
    iops_wr            = 0
    iops_wr_max        = 0
    iops_wr_max_length = 0
    iothread           = 1
    mbps               = 0
    mbps_rd            = 0
    mbps_rd_max        = 0
    mbps_wr            = 0
    mbps_wr_max        = 0
    replicate          = 0
    size               = "256G"
    slot               = 1
    ssd                = 0
    storage            = "local-zfs"
    type               = "scsi"
    volume             = "local-zfs:vm-310-disk-0"
  }

  network {
    bridge = "vmbr0"
    firewall = true
    link_down = false
    macaddr = "AA:BB:8F:FD:69:E6"
    model = "virtio"
    mtu = 0
    queues = 0
    rate = 0
    tag = -1
  }

}

resource "proxmox_vm_qemu" "skywalker-worker-1" {
  name = "skywalker-worker-1"
  target_node = "alderaan"
  full_clone = false
  qemu_os = "l26"
  scsihw = "virtio-scsi-single"

  tags = "kubernetes"

  agent = 1
  boot = "order=scsi0;net0"
  cores = 8
  memory = 4096

  onboot = true
  oncreate = false
  define_connection_info = false

  disk {
    backup = true
    cache = "none"
    file = "vm-311-disk-0"
    format = "raw"
    iops = 0
    iops_max = 0
    iops_max_length    = 0
    iops_rd            = 0
    iops_rd_max        = 0
    iops_rd_max_length = 0
    iops_wr            = 0
    iops_wr_max        = 0
    iops_wr_max_length = 0
    iothread           = 1
    mbps               = 0
    mbps_rd            = 0
    mbps_rd_max        = 0
    mbps_wr            = 0
    mbps_wr_max        = 0
    replicate          = 0
    size               = "64G"
    slot               = 0
    ssd                = 0
    storage            = "local-zfs"
    type               = "scsi"
    volume             = "local-zfs:vm-311-disk-0"
  }

  disk {
    backup = true
    cache = "none"
    file = "vm-311-disk-1"
    format = "raw"
    iops = 0
    iops_max = 0
    iops_max_length    = 0
    iops_rd            = 0
    iops_rd_max        = 0
    iops_rd_max_length = 0
    iops_wr            = 0
    iops_wr_max        = 0
    iops_wr_max_length = 0
    iothread           = 1
    mbps               = 0
    mbps_rd            = 0
    mbps_rd_max        = 0
    mbps_wr            = 0
    mbps_wr_max        = 0
    replicate          = 0
    size               = "256G"
    slot = 1
    ssd                = 0
    storage            = "local-zfs"
    type               = "scsi"
    volume             = "local-zfs:vm-311-disk-1"
  }

  network {
    bridge = "vmbr0"
    firewall = true
    link_down = false
    macaddr = "AA:BB:33:0B:29:8F"
    model = "virtio"
    mtu = 0
    queues = 0
    rate = 0
    tag = -1
  }
}
