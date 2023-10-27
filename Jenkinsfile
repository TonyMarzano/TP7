pipeline {
    agent any

    stages {
        stage('Construir y etiquetar imagen Docker') {
            steps {
                sh 'docker build -t miaplicacion:${BUILD_NUMBER} .'
            }
        }
        stage('Ejecutar contenedor Docker') {
            steps {
                script {
                    def existingContainer = sh(script: 'docker ps -aq --filter "name=miaplicacion"', returnStatus: true)
                    if (existingContainer == 0) {
                        sh 'docker run -d --name miaplicacion -p 8080:80 miaplicacion:${BUILD_NUMBER}'
                    } else {
                        sh 'docker stop miaplicacion'
                        sh 'docker rm miaplicacion'
                        sh 'docker run -d --name miaplicacion -p 8080:80 miaplicacion:${BUILD_NUMBER}'
                    }
                }
            }
        }
        stage('Ejecutar pruebas') {
            steps {
                // Agrega aquí tus pruebas
                // Ejemplo: sh 'docker exec miaplicacion comando_de_prueba'
            }
        }
        stage('Subir imagen a DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                    sh "docker login -u ${DOCKERHUB_USERNAME} -p ${DOCKERHUB_PASSWORD}"
                    sh "docker push miaplicacion:${BUILD_NUMBER}"
                }
            }
        }
    }
}
