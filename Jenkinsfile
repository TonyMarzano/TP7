pipeline {
    agent any

    environment {
        DOCKER_HUB_REPO = 'SantinoTona/webserver'
        IMAGE_VERSION = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
        CONTAINER_NAME = 'mi_contenedor'
        NGINX_PORT = 8080
    }

    stages {
        stage('Construir y etiquetar imagen') {
            steps {
                script {
                    def customImage = docker.build("${DOCKER_HUB_REPO}:${IMAGE_VERSION}", '.')
                }
            }
        }

        stage('Detener y eliminar contenedor existente') {
            steps {
                script {
                    sh "docker stop ${CONTAINER_NAME} || true"
                    sh "docker rm ${CONTAINER_NAME} || true"
                }
            }
        }

        stage('Ejecutar contenedor') {
            steps {
                script {
                    sh "docker run -d --name ${CONTAINER_NAME} -p ${NGINX_PORT}:80 ${DOCKER_HUB_REPO}:${IMAGE_VERSION}"
                }
            }
        }

        stage('Ejecutar pruebas') {
            steps {
                // Aquí debes incluir los comandos para realizar pruebas en tu aplicación dentro del contenedor.
                // Puedes utilizar herramientas como curl o wget para verificar que la aplicación esté funcionando.
                // Por ejemplo, podrías verificar que se puede acceder a un recurso específico a través de HTTP.
            }
        }

        stage('Subir imagen a Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh "docker login -u $USERNAME -p $PASSWORD"
                        sh "docker push ${DOCKER_HUB_REPO}:${IMAGE_VERSION}"
                    }
                }
            }
        }
    }

    post {
        always {
            // Limpieza: detener y eliminar el contenedor
            sh "docker stop ${CONTAINER_NAME} || true"
            sh "docker rm ${CONTAINER_NAME} || true"
        }
    }
}

