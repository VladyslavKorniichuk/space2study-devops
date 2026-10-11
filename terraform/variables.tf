variable "frontend_port" {
  description = "Nginx Load Balancer"
  type = number
  default = 80
}

variable "environment" {
  description = "ENV"
  type = string
  default = "production"
}