# Project Report

## 1. Project Selection
- **Selected Project:** Space2Study (Node.js, React, MongoDB)
- **Status:** Initialized

## 2. Completed Tasks

### Task: Setup a Webapp
- **Status:** ✅ Done
- Verified application logic locally (Windows 11).
- Confirmed baseline client-server communication (localhost:3000 / localhost:5000).

### Task: Setup a Webapp (Oracle Linux VMs)*
- **Status:** ✅ Done
- **Stack:** Oracle Linux 9.3 (Vagrant), Node.js 18, MongoDB 6.0.
- **Config:** Exposed ports 3000 & 5000 via firewalld, set up cross-host DB connection.
- **Result:** Application running at http://192.168.56.10:3000.

### Task: Implement Automatisation Setup a Webapp (Ansible)
- **Status:** ✅ Done
- **Stack:** Distributed Multi-VM (Backend: `192.168.56.20`, Frontend: `192.168.56.21`).
- **Automation:** Configured `playbook.yml` and `inventory.ini` for unattended deployment, firewalld, and systemd daemons.
- **Result:** Execution finished with `failed=0`. Verified full-stack app at `http://192.168.56.21:3000`.

### Task: Deploying a Containerized Web Application
- **Status:** ✅ Done
- **Backend Container:** Custom image based on `node:18-slim`, non-root execution (`USER node`), layer caching.
- **Frontend Container:** Production multi-stage build (`node:18-alpine` builder -> `nginx:alpine` runtime) with SPA routing rules (`try_files`).
- **Orchestration:** Implemented `docker-compose.yml` deploying Frontend, Backend, and MongoDB with isolated bridge networking and persistent storage volumes.
- **Result:** Successfully deployed containerized stack accessible at `http://localhost:3000`.

### Task: Setup Load Balancing for Webapp
- **Status:** ✅ Done
- **Cluster:** Replicated backend into 2 instances (`backend1`, `backend2`).
- **Routing:** Web traffic (`/`) routed to frontend container; API traffic (`/api`) balanced across backend cluster.
- **Result:** Unified application accessible via `http://localhost`.