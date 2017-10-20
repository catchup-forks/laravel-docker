#!/usr/bin/env groovy

node('master') {
    try {
        stage('build') {
            checkout scm
            // Install dependencies
            dir('src') {
                sh "composer install"
                sh "cp .env.example .env"
                sh "php artisan key:generate"
            }
        }

        stage('test') {
            dir('src') {
                sh './vendor/bin/phpunit'
            }
        }

        if (env.BRANCH_NAME == 'master') {
            stage('package') {

                docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                    def image = docker.build("paulredmond/laravel-docker:${env.BUILD_NUMBER}")
                    
                    image.push()
                }

                // sh 'docker build -t paulredmond/laravel-docker .'
                // sh 'docker push paulredmond/laravel-docker'
            }

            stage('Verify deployment') {
                steps {
                    input "Does everything look ok?"
                }
            }

            stage('Deploy') {
                steps {
                    sh "echo 'Deployed BUILD ${env.BUILD_NUMBER}'"
                }
            }
        }
    } catch (error) {
        throw error;
    } finally {
        
    }
}