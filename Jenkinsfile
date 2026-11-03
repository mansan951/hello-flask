pipeline {
    agent any

    environment {
        IMAGE     = "manoj053/hello-flask"
        DOCKERHUB = credentials('dockerhub-creds')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Test') {
            steps {
                sh 'docker build --target test -t $IMAGE:test .'
            }
        }

        stage('Build Image') {
            steps {
                sh 'docker build -t $IMAGE:$BUILD_NUMBER -t $IMAGE:latest .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                sh 'echo "$DOCKERHUB_PSW" | docker login -u "$DOCKERHUB_USR" --password-stdin'
                sh 'docker push $IMAGE:$BUILD_NUMBER'
                sh 'docker push $IMAGE:latest'
            }
        }
    }

    post {
        always {
            sh 'docker logout || true'
        }
    }
}
