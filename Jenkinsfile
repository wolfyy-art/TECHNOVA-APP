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
}
