variable "namespace" {
  description = "Namespace for monitoring stack"
  type        = string
}

variable "alertmanager_email" {
  description = "Alertmanager email address"
  type        = string
}

variable "alertmanager_email_password" {
  description = "SMTP app password"
  type        = string
  sensitive   = true
}

variable "grafana_admin_password" {
  type      = string
  sensitive = true
}

variable "prometheus_retention" {
  type    = string
  default = "7d"
}

variable "grafana_persistence_enabled" {
  type    = bool
  default = false
}