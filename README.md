# AWS Scalable & Secure Infrastructure-as-Code (IaC)
## 📌 Project Overview
This project demonstrates a production-ready, highly available, and secure cloud infrastructure on AWS, fully automated using **Terraform**. The architecture focuses on the **Infrastructure-as-Code (IaC)** principle to ensure consistency, scalability, and security across environments.

The core objective is to host a containerized application on a serverless stack while maintaining strict network isolation for data services and automating the entire deployment lifecycle.

## 🏗️ Architecture Highlights
The infrastructure is built on a **Multi-AZ (Availability Zone)** strategy to ensure 99.99% resilience.

### 🛡️ Network & Security
- **VPC Design:** Custom VPC with Public and Private (Data) subnets across multiple AZs.
- **Isolation:** All critical data services (RDS, Redis, MQ) are isolated in Private Subnets with no direct internet access.
- **Traffic Management:** **Application Load Balancer (ALB)** manages incoming traffic and routes it to healthy containers.
- **Security Groups:** Implemented the "Least Privilege" principle for all service communications.

### 🚀 Compute & Containers
- **ECS Fargate:** Serverless container orchestration, removing the need to manage underlying EC2 instances.
- **Docker & ECR:** Applications are containerized with Docker and stored in **Amazon Elastic Container Registry (ECR)**.
- **Storage:** **Amazon EFS** integrated for persistent, shared storage across containers.

### 💾 Data & Messaging
- **RDS (PostgreSQL):** Managed relational database with Multi-AZ failover.
- **ElastiCache (Redis):** High-performance in-memory caching layer.
- **Amazon MQ:** Managed message broker for asynchronous communication.

### 🔄 CI/CD Pipeline
- **Automated Deployment:** A full pipeline using **AWS CodePipeline**, **CodeCommit**, and **CodeBuild**.
- **Continuous Integration:** Automated Docker builds and pushes to ECR upon code changes.
- **Blue/Green Strategy:** Designed for zero-downtime updates.

### 📊 Observability
- **Monitoring:** Centralized logging and metrics via **Amazon CloudWatch**.
- **Search & Analytics:** **OpenSearch** (formerly Elasticsearch) integration for deep log analysis and system visibility.

## 🛠️ Technologies Used
- **IaC:** Terraform
- **Cloud:** AWS (VPC, ECS, RDS, EFS, MQ, ElastiCache, ALB, ECR, Route53)
- **CI/CD:** AWS CodePipeline, CodeBuild
- **Containers:** Docker
- **Monitoring:** CloudWatch, OpenSearch, VPC Flow Logs

## 🚀 How to Deploy
1. **Prerequisites:** Install Terraform and configure AWS CLI.
2. **Initialize:** `terraform init`
3. **Plan:** `terraform plan`
4. **Apply:** `terraform apply`

## 📧 Contact
www.linkedin.com/in/defneew


Project Link: [Your GitHub Repo Link]
