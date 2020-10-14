resource "digitalocean_kubernetes_cluster" "test-terraform" {
  name    = "test-terraform"
  region  = "fra1"
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.18.8-do.1"

  node_pool {
    name       = "pool1"
    size       = "s-2vcpu-4gb"
    node_count = "3"
  }
}


variable "pool-name-1" {
    type = string
}

variable "pool-name-2" {
    type = string
}

variable "node-count-1" {
    type = string
}

variable "node-count-2" {
    type = string
}

variable "label-key" {
  type = string
}

variable "label-value" {
  type = string
}


resource "digitalocean_kubernetes_node_pool" "pool1" {
#   cluster_id = var.clsuter-id
  cluster_id = digitalocean_kubernetes_cluster.test-terraform.id

  name       = var.pool-name-1
  size       = "s-4vcpu-8gb"
  node_count = var.node-count-1
  tags       = [var.pool-name-1]

  labels = {
    service  = "backend"
    priority = "high"
  }
}

resource "digitalocean_kubernetes_node_pool" "pool2" {
#   cluster_id = var.clsuter-id
  cluster_id = digitalocean_kubernetes_cluster.test-terraform.id

  name       = var.pool-name-2
  size       = "s-4vcpu-8gb"
  node_count = var.node-count-2
  tags       = [var.pool-name-1]

  labels = {
    (var.label-key) = (var.label-value)
  }

  depends_on = [digitalocean_kubernetes_node_pool.pool2]
}

output "cluster-id" {
    value = digitalocean_kubernetes_cluster.test-terraform.id
}

