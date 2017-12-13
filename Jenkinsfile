pipeline {
    agent any

    stages {
        stage('Test1') {
            steps {
                sh './test1a.sh'
                sh './test1b.sh'
            }
        }
        stage('Test2') {
            steps {
                sh './test2.sh'
            }
        }
        stage('Build') {
            steps {
                sh './build.sh $(git rev-parse HEAD)'
            }
        }
    }
}
