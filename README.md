# DevOps End-to-End CI/CD Project Documentation

## Project Overview
As part of my DevOps training, I successfully built a complete CI/CD pipeline project from scratch using various DevOps tools and technologies. This documentation outlines the entire process, practical steps, tools used, configuration details.

---

## Tech Stack Used
- **GitHub** – Version Control System
- **Jenkins** – CI/CD Tool
- **Terraform** – Infrastructure as Code
- **Ansible** – Configuration Management
- **Nexus** – Artifact Repository
- **SonarQube** – Code Quality Analysis
- **Docker** – Containerization
- **Kubernetes** – Orchestration
- **Helm Charts** – Kubernetes Package Manager
- **Prometheus** – Monitoring
- **Grafana** – Visualization

---

## End-to-End Steps Performed

### 1. Setup Terraform
- Installed Terraform on local machine.
- Wrote `.tf` files to provision EC2 instances for Jenkins Master, Jenkins Build Node, and Ansible.
- Command used:
  ```bash
  terraform init
  terraform plan
  terraform apply
  ```

### 2. Provision Jenkins Master, Build Node & Ansible using Terraform
- Defined VPC, Security Groups, Key Pairs, EC2 Instances.
- Created main.tf file

### 3. Set up Ansible Server
- Installed Ansible manually on the provisioned EC2 instance.
- Configured `/etc/ansible/hosts` with Jenkins master/build IPs.

### 4. Configure Jenkins Master & Build Node using Ansible
- Wrote playbooks for:
  - Installing Java & Jenkins
  - Adding Jenkins repo & key
  - Starting Jenkins service
  - Creating build agent 
- Sample command:
  ```bash
  ansible-playbook jenkins-setup.yml
  ```
- Files stored in: `config/Ansible/jenkins.yml`

### 5. Create a Jenkins Pipeline Job
- Configured a freestyle job initially.
- Then created a Multibranch Pipeline job.

### 6. Create Jenkinsfile from Scratch
- Defined stages:
  - Clone
  - Code Quality Check
  - Build Docker Image
  - Push to Nexus
  - Deploy to Kubernetes

### 7. Enable Webhook on GitHub
- Added Jenkins URL in GitHub webhook section.
- Used GitHub plugin in Jenkins.

### 8. Configure SonarQube & Sonar Scanner
- Installed SonarQube on separate EC2.
- Integrated with Jenkins using credentials and server URL.
- Used Sonar Scanner CLI.

### 9. Execute SonarQube Analysis
- In Jenkinsfile:
  ```groovy
  withSonarQubeEnv('MySonarServer') {
    sh 'sonar-scanner'
  }
  ```

### 10. Nexus Setup
- Installed Nexus on Jenkins server.
- Created Docker hosted repository.
- Allowed anonymous access for demo.

### 11. Create Dockerfile
- Wrote a Dockerfile for static HTML/CSS app:
  ```dockerfile
  FROM nginx:alpine
  COPY . /usr/share/nginx/html
  ```
- Stored in GitHub repo.

### 12. Store Docker Images on Nexus Artifactory
- Tagged and pushed:
  ```bash
  docker tag maindemo nexus_ip:port/repo/myapp:v1
  docker push nexus_ip:port/repo/myapp:v1
  ```

### 13. Provision Kubernetes Cluster using Terraform
- Provisioned Master & Worker EC2 instances.
- Installed Kubernetes (kubeadm, kubelet, kubectl).
- Used Calico for networking.

### 14. Create Kubernetes Objects
- Created YAMLs for:
  - Deployment
  - Service
- Files stored in: `~/k8s-manifests/`

### 15. Deploy using Helm
- Wrote `values.yaml`, `Chart.yaml`, `templates/`.
- Installed Helm:
  ```bash
  helm install myapp ./mychart
  ```

### 16. Setup Prometheus & Grafana using Helm
- Used community Helm charts:
  ```bash
  helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
  helm install prometheus prometheus-community/kube-prometheus-stack
  ```

### 17. Monitor Kubernetes Cluster using Prometheus
- Visualized metrics in Grafana.

---


