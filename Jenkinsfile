pipeline {
    agent any
    tools{
        maven "maven-3"
    }

    stages {

        
        stage('compile') {
            steps {
                sh 'mvn compile'
            }
        }
        
        stage('test') {
            steps {
                sh 'mvn test'
            }
        }
        
        
        stage('package') {
            steps {
                sh 'mvn package'
            }
        }

        stage('added') {
            steps {
                sh 'echo "hello world"'
            }
        }
    }
}
