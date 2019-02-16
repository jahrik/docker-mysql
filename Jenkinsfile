#!/usr/bin/env groovy

env.MYSQL_ROOT_PASSWORD=""
env.MYSQL_DATABASE=""
env.MYSQL_USER=""
env.MYSQL_PASSWORD=""

node('manager') {

    try {

        stage('build') {
            // Clean workspace
            deleteDir()
            // Checkout the app at the given commit sha from the webhook
            checkout scm
            sh "make"
        }

        stage('test') {
            echo "Running ${env.BUILD_ID} on ${env.JENKINS_URL}"
            // Run any testing suites
        }

        stage('push') {
            // Push to Dockerhub
            sh "make push"
        }

        stage('deploy') {
            sh "make deploy"
        }

    } catch(error) {
        throw error

    } finally {
        // Any cleanup operations needed, whether we hit an error or not

    }
}
