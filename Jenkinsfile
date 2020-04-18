pipeline {
  agent any
  stages {
    stage('Unit Test for develop branch') {
      when { branch 'develop' { false } }
      hide true
      steps {
        bat 'mvn clean install'
      }
    }
    stage('q Test') {
      when {
            branch 'master'
      }
      steps {
        bat 'echo Enquero'
        bat 'mvn -version'
      }
    }
  }
}
 
