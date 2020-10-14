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

resource "helm_release" "mydatabase" {
  name  = var.database-name
  chart = "helm-repo/postgresql"

  set {
    name  = "postgresqlUsername"
    value = var.username
  }

  set {
    name  = "postgresqlPassword"
    value = var.password
  }

#   set {
#     type = "string"  
#     name  = "master.affinity.podAffinity.requiredDuringSchedulingIgnoredDuringExecution[0].labelSelector.matchExpressions[0].key"
#     value = var.label-key
#   }

  set {
    # type = "string"  
    name  = "master.affinity.nodeAffinity.requiredDuringSchedulingIgnoredDuringExecution.nodeSelectorTerms[0].matchExpressions[0].key"
    value = var.label-key
  }

#   set {
#     type = "string"  
#     name  = "master.affinity.podAffinity.requiredDuringSchedulingIgnoredDuringExecution[0].labelSelector.matchExpressions[0].values[0]"
#     value = var.label-value
#   }

  set {
    # type = "string"  
    name  = "master.affinity.nodeAffinity.requiredDuringSchedulingIgnoredDuringExecution.nodeSelectorTerms[0].matchExpressions[0].values[0]"
    value = var.label-value
  }       

#   set {
#     type = "string"  
#     name  = "slave.affinity.podAffinity.requiredDuringSchedulingIgnoredDuringExecution[0].labelSelector.matchExpressions[0].key"
#     value = var.label-key
#   }

  set {
    # type = "string"  
    name  = "slave.affinity.nodeAffinity.requiredDuringSchedulingIgnoredDuringExecution.nodeSelectorTerms[0].matchExpressions[0].key"
    value = var.label-key
  }

#   set {
#     type = "string"  
#     name  = "slave.affinity.podAffinity.requiredDuringSchedulingIgnoredDuringExecution[0].labelSelector.matchExpressions[0].values[0]"
#     value = var.label-value
#   }

  set {
    # type = "string"  
    name  = "slave.affinity.nodeAffinity.requiredDuringSchedulingIgnoredDuringExecution.nodeSelectorTerms[0].matchExpressions[0].values[0]"
    value = var.label-value
  }      

  set {
    # type = "string"  
    name  = "master.affinity.nodeAffinity.requiredDuringSchedulingIgnoredDuringExecution.nodeSelectorTerms[0].matchExpressions[0].operator"
    value = "In"
  }  

  set {
    # type = "string"  
    name  = "slave.affinity.nodeAffinity.requiredDuringSchedulingIgnoredDuringExecution.nodeSelectorTerms[0].matchExpressions[0].operator"
    value = "In"
  }  
}