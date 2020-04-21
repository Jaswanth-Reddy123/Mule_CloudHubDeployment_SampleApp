pipeline {
  agent any
  stages {
    stage('Initializing') {
      steps {
        bat 'echo Building Project Mule Soft Deployment '
      }
    }
    stage('Build and package') {
      steps {
	       bat 'mvn clean package'
      }
    }
    stage('Deploy') {
      steps {
	       bat 'mvn deploy'      
      }
    }
    stage('Update Deployment status') {
      steps {
	      bat 'echo "Integrate with Email or any other Communication channel" '
      }
  }
    stage('Promote') {
      steps {
	     input("promote to UAT Environment?") 
	    bat 'echo Publishing Test reports '
      }
  }
}
}
