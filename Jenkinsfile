pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building the application...'
            }
        }
        stage('Test') {
            steps {
                echo 'Running tests...'
            }
        }
        
        stage('code analysis with sonarqube') {
            environment {
                scannerHome = tool 'sonar-scanner-7'
            }
            steps {
                withSonarQubeEnv('sonar-server') {
                    sh '''${scannerHome}/bin/sonar-scanner \
                        -Dsonar.projectKey=nikhilzach_maindemo \
                        -Dsonar.projectName=nikhilzach_maindemo \
                        -Dsonar.projectVersion=1.0 \
                        -Dsonar.sources=src/ \
                        -Dsonar.organization=nikhilzach'''
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying the application...'
            }
        }
    }
}
