pipeline {
    agent any

    stages {
        stage('Test1') {
            steps {
                parallel (
                    "Test 1A": {
                        sh './test1a.sh'
                    },
                    "Test 1B": {
                        sh './test1b.sh'
                    }
                )
            }
        }
        stage('Test2') {
            steps {
                sh './test2.sh'
            }
        }
    }
    post {
        success {
            sh './build.sh $(git rev-parse HEAD)'
        }
    }
}
