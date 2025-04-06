pipeline {
    agent any

    environment {
        SONAR_SCANNER_HOME = tool 'SonarScanner'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/nikhilzach/maindemo.git'
            }
        }


        stage('Archive Site Files') {
            steps {
                archiveArtifacts artifacts: '**/*', fingerprint: true
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying static site...'
                // Example deployment to a remote EC2 instance with Nginx
                sh 'scp -r * ubuntu@65.2.63.218:/var/www/html'
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
