pipeline {
    agent any


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
        sh 'cp -r * /var/www/html'
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
