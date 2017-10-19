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
                sh 'docker build -t paulredmond/laravel-docker .'
                //sh 'docker push paulredmond/laravel-docker'
            }
        }
    } catch (error) {
        throw error;
    } finally {
        
    }
}