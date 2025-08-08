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
## 🧰 Tools & Technologies Used

| Category         | Tools & Technologies                     |
|------------------|------------------------------------------|
| Language         | Node.js (Express.js)                     |
| Source Control   | Git & GitHub                             |
| CI/CD            | Jenkins                                  |
| Containerization | Docker                                   |
| Provisioning     | Terraform                                |
| Cloud Platform   | AWS EC2                                  |
| Access           | AWS IAM, SSH                             |

---

  Folder Structure

TECHNOVA-APP/
├── Dockerfile # Docker build config
├── index.js # Main server file
├── package.json # Dependencies and metadata
├── terraform/ # Terraform scripts for EC2, IAM, etc.
└── Jenkinsfile # Jenkins pipeline config

Step-by-Step Setup

### Step 1: Clone the Repository

```bash
git clone https://github.com/wolfyy-art/TECHNOVA-APP.git
cd TECHNOVA-APP
```

---

## 🖥️ Node.js App Setup

### 1. Install Node.js (on EC2 or locally)

```bash
curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
sudo yum install -y nodejs
```

### 2. Install dependencies

```bash
npm install
```

### 3. Run App Manually (for testing)

```bash
node index.js
# OR add to scripts in package.json and run:
npm start
```

---

## 🐳 Docker Setup

### 1. Docker Installation (on EC2)

```bash
sudo yum update -y
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user
newgrp docker
```

### 2. Dockerfile

Ensure `Dockerfile` exists with content like:

```
FROM node:18
WORKDIR /app
COPY . .
RUN npm install
EXPOSE 3000
CMD ["node", "index.js"]
```

### 3. Build & Run Docker Container

```bash
docker build -t technova-app .
docker run -d -p 80:3000 technova-app
docker ps
```

### 4. View Logs (optional)

```bash
docker logs <container_id>
```

---

## 🌐 AWS Infrastructure Provisioning via Terraform

### 1. Terraform Setup

```bash
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform
terraform -install-autocomplete
```

### 2. Create Key Pair for SSH

```bash
aws ec2 create-key-pair --key-name technova-key --query "KeyMaterial" --output text > technova.pem
chmod 400 technova.pem
```

### 3. Configure AWS CLI

```bash
aws configure
# Enter Access Key, Secret, Region (e.g., ap-south-1)
```

### 4. Terraform Workflow

Navigate to terraform directory:

```bash
cd terraform
```

Then run:

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

### 5. Output IP

Note down the public IP of the EC2 instance from Terraform output.

### 6. SSH into EC2

```bash
ssh -i technova.pem ec2-user@<EC2_PUBLIC_IP>
```

---
## 🔧 Jenkins CI/CD Setup

### 1. Jenkins Installation (on Ubuntu)

```bash
sudo apt update
sudo apt install openjdk-17-jdk -y
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins
```

Access Jenkins at:
```
http://<JENKINS_IP>:8080
```

Unlock with:
```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

### 2. Jenkins Pipeline Setup

- Install Git, Docker, and Pipeline plugins in Jenkins
- Create New Pipeline project
- Use this `Jenkinsfile` in the repo

```groovy
pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
                git 'https://github.com/wolfyy-art/TECHNOVA-APP.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t technova-app .'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh 'docker rm -f technova-app || true'
                sh 'docker run -d -p 80:80 --name technova-app technova-app'
            }
        }
    }

    post {
        success {
            emailext(
                subject: "✅ Deployment Successful",
                body: "The TECHNOVA app was deployed successfully.",
                to: 'sarohamayank314@gmail.com'
            )
        }
        failure {
            emailext(
                subject: "❌ Deployment Failed",
                body: "The TECHNOVA app deployment failed. Please check Jenkins logs.",
                to: 'sarohamayank314@gmail.com'
            )
        }
    }
}

```
<img width="1913" height="883" alt="Screenshot 2025-08-08 151526" src="https://github.com/user-attachments/assets/46043c33-3a94-4dbe-8030-96df22355e86" />

## 🔐 IAM User and Access

To run Terraform or configure AWS CLI securely, create an IAM user with programmatic access and assign EC2 & VPC full access permissions.

Then use the access keys with:

```bash
aws configure
```

---

## 🧼 Clean Up

To destroy resources:

```bash
cd terraform
terraform destroy
```

To stop Docker:

```bash
docker ps
docker stop <container_id>
```

---

## 🙋‍♂️ Author

**Mayank Saroha**  
GitHub: [@wolfyy-art](https://github.com/wolfyy-art)

---

## 📃 License

MIT License

Testing
http://13.222.185.243
## ✅ Final Output
<img width="439" height="234" alt="Screenshot 2025-08-08 151629" src="https://github.com/user-attachments/assets/90d35adb-5bb2-4f3a-b48f-7b1034c72db4" />

After successful deployment, visit:

```
http://<EC2_PUBLIC_IP>
```


You should see: `Welcome to TechNova App!`

---

