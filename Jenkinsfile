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
