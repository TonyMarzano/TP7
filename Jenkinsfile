pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = 'mi-app:latest'  // Nombre de la imagen Docker
    }

    stages {
        stage('Construir y etiquetar imagen') {
            steps {
                script {
                    // Construir la imagen Docker y etiquetarla
                    sh 'docker build -t $DOCKER_IMAGE .'
                }
            }
        }
        
        stage('Ejecutar contenedor') {
            steps {
                script {
                    // Detener y eliminar un contenedor si ya existe con el mismo nombre
                    sh 'docker stop mi-app || true'
                    sh 'docker rm mi-app || true'

                    // Ejecutar el contenedor con el puerto y el nombre deseado
                    sh 'docker run -d --name mi-app -p 8080:80 $DOCKER_IMAGE'
                }
            }
        }

        stage('Ejecutar pruebas') {
            steps {
                // Agrega aquí comandos para ejecutar pruebas, como verificar la disponibilidad del archivo de configuración
            }
        }

        stage('Subir imagen a DockerHub') {
            when {
                expression { currentBuild.resultIsBetterOrEqualTo('SUCCESS') }
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                    script {
                        sh "docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD"
                        sh "docker push $DOCKER_IMAGE"
                    }
                }
            }
        }
    }

    post {
        always {
            // Limpia y elimina el contenedor
            sh 'docker stop mi-app || true'
            sh 'docker rm mi-app || true'
        }
    }
}
