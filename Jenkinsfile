pipeline {
    agent any

    environment {
        SONAR_HOST_URL = 'http://13.234.19.247:9000/'
        IMAGE_NAME = '13.203.207.251:8082/maindemo:latest'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/nikhilzach/maindemo.git'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withCredentials([string(credentialsId: 'SONAR_TOKEN', variable: 'SONAR_TOKEN')]) {
                    echo 'Running SonarQube analysis...'
                    sh '''
                        /opt/sonar-scanner/bin/sonar-scanner \
                        -Dsonar.projectKey=maindemo \
                        -Dsonar.sources=. \
                        -Dsonar.host.url=$SONAR_HOST_URL \
                        -Dsonar.login=$SONAR_TOKEN
                    '''
                }
            }
        }


        stage('Build & Push Docker Image') {
    steps {
        withCredentials([usernamePassword(credentialsId: 'NEXUS_CREDS', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
            sh '''
                docker build -t 13.203.207.251:8082/maindemo:latest .
                echo "$PASSWORD" | docker login 13.203.207.251:8082 -u "$USERNAME" --password-stdin
                docker push 13.203.207.251:8082/maindemo:latest
            '''
        }
    }
}

        stage('Docker Login & Pull') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'NEXUS_CREDS', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh '''
                        echo "$PASSWORD" | docker login 13.203.207.251:8082 -u "$USERNAME" --password-stdin
                        docker pull $IMAGE_NAME
                    '''
                }
            }
        }

        stage('Deploy Docker Container') {
            steps {
                echo 'Deploying Docker container...'
                sh '''
                    docker stop maindemo || true
                    docker rm maindemo || true
                    docker run -d --name maindemo -p 8085:80 $IMAGE_NAME
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline completed successfully!'
        }
        failure {
            echo '❌ Pipeline failed!'
        }
    }
}
