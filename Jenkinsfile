pipeline {
    agent any

    environment {
        dockerImage = 'miImagenDocker' // nombre de la imagen de Docker
        dockerTag = "1.0.${env.BUILD_NUMBER}" // esquema de versionado
    }

    stages {
        stage('Build') {
            steps {
                script {
                    sh 'docker build -t $dockerImage:$dockerTag .' // construir la imagen y taggear
                }
            }
        }
        stage('Run and Test') {
            steps {
                script {
                    sh 'docker run -d --name miContenedor $dockerImage:$dockerTag' // ejecutar la imagen en un contenedor
                    // realizar pruebas en el contenedor
                    // ejemplo: sh 'docker exec miContenedor comando_de_prueba'
                }
            }
        }
        stage('Publish') {
            steps {
                script {
                    withDockerRegistry([credentialsId: 'dockerhub-credentials', url: 'https://registry.hub.docker.com']) {
                        sh "docker login -u user -p password"
                        sh "docker push $dockerImage:$dockerTag" // subir la imagen a DockerHub
                    }
                }
            }
        }
    }
}
