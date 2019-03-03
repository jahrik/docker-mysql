#!/usr/bin/env groovy

mysql_root_pass = 'mysql-root-pass'
mysql_user_pass = 'mysql-user-pass'
mysql_database = 'mysql-database'

node('aarch64') {

    try {

        stage('scm') {
            deleteDir()
            checkout scm
        }

        stage('build') {
            sh "make"
        }

        stage('push') {
            sh "make push"
        }

    } catch(error) {
        throw error

    } finally {

    }
}

node('manager') {

    try {

        stage('scm') {
            deleteDir()
            checkout scm
        }

        stage('deploy') {
          withCredentials([
            usernamePassword(credentialsId: mysql_user_pass,
              usernameVariable: 'MYSQL_USER',
              passwordVariable: 'MYSQL_PASSWORD'),
            string(credentialsId: mysql_root_pass,
              variable: 'MYSQL_ROOT_PASSWORD'),
            string(credentialsId: mysql_database,
              variable: 'MYSQL_DATABASE')]) {
              sh "make deploy"
            }
        }

    } catch(error) {
        throw error

    } finally {

    }
}
