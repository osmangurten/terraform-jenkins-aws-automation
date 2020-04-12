pipeline {
  agent any
  environment {
    PATH = "${PATH}:${getTerraformPath()}"
  }
stages {
  stage('terraform init and apply -dev'){
    steps{
    sh "terraform init -input=false"
    sh "terraform apply -auto-approve"
      }
    }
  }
}
def getTerraformPath(){
  tfHome = tool name: 'terraform-12', type: 'org.jenkinsci.plugins.terraform.TerraformInstallation'
  return tfHome
  }
