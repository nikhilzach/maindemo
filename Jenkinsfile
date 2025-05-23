pipeline {
    agent any

    environment {
        SONAR_HOST_URL = 'http://65.2.29.180:9000'
        IMAGE_NAME = '13.203.129.251:8082/maindemo:latest'
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


        stage('Build & Push Image to Nexus') {
    steps {
        withCredentials([usernamePassword(credentialsId: 'NEXUS_CREDS', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
            sh '''
                docker build -t 13.203.129.251:8082/maindemo:latest .
                echo "$PASSWORD" | docker login 13.203.129.251:8082 -u "$USERNAME" --password-stdin
                docker push 13.203.129.251:8082/maindemo:latest
            '''
        }
    }
}

        stage('Docker Login & Pull') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'NEXUS_CREDS', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh '''
                        echo "$PASSWORD" | docker login 13.203.129.251:8082 -u "$USERNAME" --password-stdin
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
stage('Deploy with Helm') {
    steps {
        sshagent(['kube-master-ssh']) {
            sh '''
                ssh -o StrictHostKeyChecking=no ubuntu@13.201.83.45 "
                    set -e
                    cd /home/ubuntu/maindemo-chart
                    helm upgrade --install maindemo . --namespace default
                    NODE_PORT=\\$(kubectl get --namespace default -o jsonpath=\\\"{.spec.ports[0].nodePort}\\\" services maindemo-service)
                    NODE_IP=\\$(kubectl get nodes --namespace default -o jsonpath=\\\"{.items[0].status.addresses[0].address}\\\")
                    echo http://\\$NODE_IP:\\$NODE_PORT
                "
            '''
        }
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
