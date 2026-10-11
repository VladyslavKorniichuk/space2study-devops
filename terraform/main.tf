# =============================================================
# Network and Volumes 
# =============================================================

resource "docker_network" "app_network" {
  name   = "space2study-tf-net"
  driver = "bridge"
}

resource "docker_volume" "mongo_data" {
  name = "space2study-tf-mongo-data"
}

# =============================================================
# DB (MongoDB) 
# =============================================================

resource "docker_container" "mongodb" {
  name    = "space2study-tf-db"
  image   = "mongo:6.0"
  restart = "unless-stopped"

  networks_advanced {
    name = docker_network.app_network.name
  }

  volumes {
    volume_name    = docker_volume.mongo_data.name
    container_path = "/data/db"
  }
}

# =============================================================
# Backend (backend1 & backend2) 
# =============================================================

resource "docker_container" "backend1" {
  name    = "space2study-tf-backend-1"
  image   = "space2study-backend:v1"
  restart = "unless-stopped"

  env = [
    "PORT=5000",
    "SERVER_PORT=5000",
    "MONGODB_URL=mongodb://space2study-tf-db:27017/space2study",
    "CLIENT_URL=http://localhost",
    "JWT_SECRET=supersecretkey12345",
    "SUPER_ADMIN_PASSWORD=Password123!"
  ]

  networks_advanced {
    name    = docker_network.app_network.name
    aliases = ["backend1"]
  }

  depends_on = [docker_container.mongodb]
}

resource "docker_container" "backend2" {
  name    = "space2study-tf-backend-2"
  image   = "space2study-backend:v1"
  restart = "unless-stopped"

  env = [
    "PORT=5000",
    "SERVER_PORT=5000",
    "MONGODB_URL=mongodb://space2study-tf-db:27017/space2study",
    "CLIENT_URL=http://localhost",
    "JWT_SECRET=supersecretkey12345",
    "SUPER_ADMIN_PASSWORD=Password123!"
  ]

  networks_advanced {
    name    = docker_network.app_network.name
    aliases = ["backend2"]
  }

  depends_on = [docker_container.mongodb]
}


# =============================================================
# Frontend
# =============================================================
resource "docker_container" "frontend" {
  name    = "space2study-tf-frontend"
  image   = "space2study-frontend:v1"
  restart = "unless-stopped"

  networks_advanced {
    name    = docker_network.app_network.name
    aliases = ["frontend"]
  }

  depends_on = [docker_container.backend1, docker_container.backend2]
}


# =============================================================
# Load Balancer (Nginx) 
# =============================================================

resource "docker_container" "loadbalancer" {
  name    = "space2study-tf-lb"
  image   = "nginx:alpine"
  restart = "unless-stopped"

  ports {
    internal = 80
    external = var.frontend_port
  }

  volumes {
    host_path      = abspath("${path.root}/../nginx-lb/default.conf")
    container_path = "/etc/nginx/conf.d/default.conf"
    read_only      = true
  }

  networks_advanced {
    name = docker_network.app_network.name
  }

  depends_on = [docker_container.frontend]
}