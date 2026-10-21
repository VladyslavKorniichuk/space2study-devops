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

### Task: Implement Infrastructure as Code
- **Status:** ✅ Done
- **Tooling:** Terraform, HCL, Docker Provider (`kreuzwerker/docker`).
- **Structure:** Modular setup with `versions.tf`, `variables.tf`, `main.tf`, and `outputs.tf`.
- **Resources:** Declaratively provisioned network (`space2study-tf-net`), persistent storage volume, and full containerized cluster (DB, 2 Backend replicas, Frontend, Nginx LB).
- **Result:** Applied infrastructure via `terraform apply` with state tracking and drift detection.

### Task: Implement a Continuous Integration/Continuous Delivery
- **Status:** ✅ Done
- **Platform:** GitHub Actions (`.github/workflows/ci.yml`).
- **Triggers:** Automated runs on `push` and `pull_request` across `main` and feature branches.
- **Pipeline Jobs:**
  - `backend-check`: Node.js 18 dependency installation and integrity validation with npm caching.
  - `frontend-check`: TypeScript/React compilation and Vite production build verification.
  - `docker-build-check`: Automated build testing for both Backend and Frontend Docker images.
- **Result:** Established automated pipeline preventing broken builds from entering production.

### Task: Artifact Management
- **Status:** ✅ Done
- **Registry:** GitHub Container Registry (`ghcr.io`).
- **Security & Auth:** Ephemeral authentication using `${{ secrets.GITHUB_TOKEN }}` without hardcoded credentials.
- **Tagging Strategy:** Automated semantic tagging based on Git commit SHA and `latest` tracking for production releases.
- **Published Artifacts:**
  - `ghcr.io/vladyslavkorniichuk/space2study-devops/backend`
  - `ghcr.io/vladyslavkorniichuk/space2study-devops/frontend`
- **Result:** Successfully automated container image lifecycle and publishing to repository Packages.

### Task: Scanning images and dependencies in CI/CD
- **Status:** ✅ Done
- **Tooling:** Aqua Security Trivy (v0.28.0), GitHub Actions.
- **SCA (Software Composition Analysis):** Automated filesystem scanning (`scan-type: 'fs'`) of `package-lock.json` dependencies for backend and frontend.
- **Container Image Scanning:** Pre-release vulnerability inspection of built Docker images (`CRITICAL,HIGH` severity filters).
- **Result:** Fully automated DevSecOps gate integrated into CI/CD prior to artifact publication.

### Task: Implement CCI (Continuous Code Inspection)
- **Status:** ✅ Done
- **Tooling:** ESLint, Static Application Analysis, GitHub Actions.
- **Scope:** Automated static inspection of backend and frontend source trees (`src/`) against `.eslintrc` quality standards.
- **Result:** Automated code quality gates established in continuous integration pipeline.

### Task: Set up monitoring tools for application performance and infrastructure health
- **Status:** ✅ Done
- **Observability Stack:** 
  - Metrics Exporter: Google **cAdvisor** for real-time container cgroups telemetry (CPU, RAM, Network).
  - Time-Series Engine: **Prometheus** scraping metrics at 5s intervals (`monitoring/prometheus.yml`).
  - Visualization: **Grafana** (port 3001) with pre-configured Prometheus data source.
- **Result:** Fully operational infrastructure observability stack accessible at `http://localhost:3001`.

### Task: Monitor resource usage and plan for scalability
- **Status:** ✅ Done
- **Capacity Planning & Resource Limits:** Configured CPU/Memory boundaries in `docker-compose.yml`:
  - Database (MongoDB): `limits: 512MB / 0.5 CPU`, `reservations: 128MB`.
  - Backend Cluster (`backend1`, `backend2`): `limits: 512MB / 0.5 CPU` each.
  - Frontend & Nginx Proxy: `limits: 128MB / 0.25 CPU` each.
- **Verification:** Validated memory quotas using `docker stats` and real-time Prometheus/cAdvisor telemetry in Grafana.