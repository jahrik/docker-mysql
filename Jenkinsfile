#!/usr/bin/env groovy

mysql_root_pass = 'mysql-root-pass'
mysql_user_pass = 'mysql-user-pass'
mysql_database = 'mysql-database'

node('aarch64') {

    try {

        stage('build') {
            deleteDir()
            checkout scm
            sh "make"
        }

        stage('push') {
            sh "make push"
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
