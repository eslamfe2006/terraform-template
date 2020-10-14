provider "digitalocean" {
    token = "922300252a4ec4dfc977cb9bbcb4234d94820eab2f5db765020c3dc387979863"
}

provider "helm" {
  kubernetes {
    config_path = "/root/.kube/config"
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

variable "username" {
  type = string
}

variable "password" {
  type = string
}

variable "label-key" {
  type = string
}

variable "label-value" {
  type = string
}

variable "database-name" {
  type = string
}


module "cluster" {
  source = "./cluster"
  pool-name-1 = var.pool-name-1
  pool-name-2 = var.pool-name-2
  node-count-1 = var.node-count-1
  node-count-2 = var.node-count-2
  label-key = var.label-key 
  label-value = var.label-value  
  # cluster-name = "test-terraform"
  # cluster-region = "fra1"
  # cluster-version = "1.18.8-do.0"
  # pool-name = "pool1"
  # node-count = "3"
}

module "db-chart" {
  source = "./db-chart"
  username = var.username
  password = var.password 
  label-key = var.label-key 
  label-value = var.label-value
  database-name = var.database-name
  depends_on = ["module.cluster"]
}

output "cluster-id" {
    value = module.cluster.cluster-id
}