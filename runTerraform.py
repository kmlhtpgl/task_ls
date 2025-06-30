def call(Map pipelineParams) {
    pipeline{
        parameters {
            choice(name: 'aws,region', choices: ['eu-west-2', 'eu-west-1'])
            # market, service_name, business_unit, tf_action and environment_name also added as parameter
        }
        agent {
            label "AWS-jenkins-slave-label"
        }

        options {
            timeout(time: 120, unit: 'MINUTES')
            timestamps()
            disableConcurrentBuilds()
            buildDiscarder(logRotator(numToKeepStr: '30', daysToKeepStr: '365'))
            ansiColor('xterm')
        }
        
        environment {
            NO_PROXY = 
            AUTH = 
        }

        stages {
            stage('init') {
                steps {
                    cleanWs()
                    deleteDir()
                    git branch: xxxxx, credentialsId: xxxxxx, url: xxxxxxxx
                }
            }

            stage('build') {
                steps {
                    sh """
                    hostname
                    git config --global 
                    python3 ${WORKSPACE}/src/template.py
                    """
                }
            }
        }
        
        post {
            always {
                cleanWs()
                deleteDir()
            }
        }
    }
}

def getAccount() {
    # if statement AWS labels return account ids
}