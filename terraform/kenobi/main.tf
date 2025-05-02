terraform {
    cloud {
        organization = "nicholasfeldman"

        workspaces {
          name = "homelab-kenobi"
        }
    }

    required_providers {
        talos = {
            source = "siderolabs/talos"
            version = ">= 0.7.1"
        }
  }
}

data "talos_image_factory_extensions_versions" "this" {
  talos_version = "v1.9.4"
  filters = {
    names = [
      "amdgpu",
      "qemu-guest-agent",
      "iscsi-tools",
      "util-linux-tools"
    ]
  }
}

resource "talos_image_factory_schematic" "this" {
  schematic = yamlencode(
    {
      customization = {
        systemExtensions = {
          officialExtensions = data.talos_image_factory_extensions_versions.this.extensions_info.*.name
        }
      }
    }
  )
}

output "schematic_id" {
  value = talos_image_factory_schematic.this.id
}

# Configuration

resource "talos_machine_secrets" "this" {}

data "talos_machine_configuration" "controlplane" {
  cluster_name     = "kenobi"
  machine_type     = "controlplane"
  cluster_endpoint = "https://10.10.90.55:6443"
  machine_secrets  = talos_machine_secrets.this.machine_secrets
}

data "talos_machine_configuration" "worker" {
  cluster_name     = "kenobi"
  machine_type     = "worker"
  cluster_endpoint = "https://10.10.90.55:6443"
  machine_secrets  = talos_machine_secrets.this.machine_secrets
}

data "talos_client_configuration" "this" {
  cluster_name         = "kenobi"
  client_configuration = talos_machine_secrets.this.client_configuration
  nodes                = [
    "10.10.90.55",
    "10.10.90.56",
    "10.10.90.57"
  ]
}

# Application

resource "talos_machine_configuration_apply" "controlplane" {
  for_each = toset(["10.10.90.55", "10.10.90.56", "10.10.90.57"])

  client_configuration        = talos_machine_secrets.this.client_configuration
  machine_configuration_input = data.talos_machine_configuration.controlplane.machine_configuration
  node                        = each.key
}

resource "talos_machine_configuration_apply" "worker" {
  for_each = toset(["10.10.90.45"])

  client_configuration        = talos_machine_secrets.this.client_configuration
  machine_configuration_input = data.talos_machine_configuration.worker.machine_configuration
  node                        = each.key
}

# Outputs

resource "talos_machine_bootstrap" "this" {
  depends_on = [
    talos_machine_configuration_apply.controlplane,
    talos_machine_configuration_apply.worker
  ]

  client_configuration = talos_machine_secrets.this.client_configuration
  node                 = "10.10.90.55"
}

data "talos_cluster_kubeconfig" "this" {
  depends_on = [talos_machine_bootstrap.this]

  client_configuration = data.talos_client_configuration.this.client_configuration
  node                 = "10.10.90.55"
}

resource "local_sensitive_file" "export_kubeconfig" {
  depends_on = [data.talos_cluster_kubeconfig.this]
  content    = data.talos_cluster_kubeconfig.this.kubeconfig_raw
  filename   = "${path.module}/output/kubeconfig"
}