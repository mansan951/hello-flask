pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Test') {
            steps {
                sh 'docker build --target test -t manoj053/hello-flask:test .'
            }
        }
        stage('Build Image') {
            steps {
                sh 'docker build --target final -t manoj053/hello-flask:latest .'
            }
        }
        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKERHUB', passwordVariable: 'DOCKERHUB_PSW')]) {
                    sh 'echo $DOCKERHUB_PSW | docker login -u $DOCKERHUB --password-stdin'
                    sh 'docker tag manoj053/hello-flask:latest manoj053/hello-flask:${BUILD_NUMBER}'
                    sh 'docker push manoj053/hello-flask:${BUILD_NUMBER}'
                    sh 'docker push manoj053/hello-flask:latest'
                }
            }
            post {
                always {
                    sh 'docker logout'
                }
            }
        }
        stage('Deploy') {
            steps {
                sh 'docker stop hello-flask || true'
                sh 'docker rm hello-flask || true'
                sh 'docker run -d --name hello-flask -p 5000:5000 manoj053/hello-flask:${BUILD_NUMBER}'
            }
        }
    }
}
