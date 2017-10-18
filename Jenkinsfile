#!/usr/bin/env groovy

node('master') {
    try {
        stage('build') {
            checkout scm
            sh "composer install"
            sh "cp .env.example .env"
            sh "php artisan key:generate"
        }

        stage('test') {
            sh './vendor/bin/phpunit'
        }
    } catch (error) {
        throw error;
    } finally {
        
    }
}