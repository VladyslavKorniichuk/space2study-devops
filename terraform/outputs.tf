output "application_url" {
  description = "App URL"
  value = "http://localhost:${var.frontend_port}"
}

output "managed_containers" {
  description = "List of containers"
  value = [
    docker_container.mongodb.name,
    docker_container.backend1.name,
    docker_container.backend2.name,
    docker_container.frontend.name,
    docker_container.loadbalancer.name
  ]
}