# TechNova DevOps Pipeline: 

 Project Overview

TechNova is a modern DevOps-based deployment pipeline designed to automate the build, test, and deployment of a web application using CI/CD best practices.

This project includes:
- Dockerized Node.js application (Express server)
- Jenkins pipeline integration
- AWS EC2 deployment
- Infrastructure provisioning via Terraform
- GitHub integration for version control and webhook automation

---

  Features

-  Fully automated CI/CD pipeline using Jenkins
-  Docker containerization for consistent environment
-  AWS EC2 for hosting the application
-  IAM roles and security group configuration
-  GitHub repository integration
-  Infrastructure as Code using Terraform

---
  Technologies Used

| Component     | Tool / Tech       | Purpose                        |
|---------------|-------------------|--------------------------------|
| Backend       | Node.js + Express | Web app server                 |
| CI/CD         | Jenkins            | Pipeline automation            |
| Version Ctrl  | Git + GitHub       | Source code management         |
| Deployment    | Docker + EC2       | Containerized deployment       |
| Provisioning  | Terraform          | Infra provisioning on AWS      |
| OS            | Amazon Linux 2023  | EC2 instance base OS           |

---

  Folder Structure

TECHNOVA-APP/
├── Dockerfile # Docker build config
├── index.js # Main server file
├── package.json # Dependencies and metadata
├── terraform/ # Terraform scripts for EC2, IAM, etc.
└── Jenkinsfile # Jenkins pipeline config

Testing
http://13.222.185.243
