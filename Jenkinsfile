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
    } catch (error) {
        throw error;
    } finally {
        
    }
}