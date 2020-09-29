pipeline {
    agent any

    stages {
        stage('Verify Branch') {
            steps {
                echo "$GIT_BRANCH"
            }
        }
        stage('Docker Build') {
            steps {
                powershell(script: 'docker images -a')
                powershell(script: """
                cd azure-vote/
                docker images -a
                docker build -t jenkins-pipeline .
                docker images -a
                cd ..
                """)
            }
        }
        stage("Start test app") {
            steps {
                powershell(script: """
                docker-compose up -d
                ./scripts/test_container.ps1
                """)
            }
            post {
                success {
                    echo "App Started Successfully"
                }
                failure {
                    echo "App failed to start :("
                }
            }
        }
        stage('Run Tests'){
            steps {
                powershell(script: """
                pytest ./tests/test_sample.py
                """)
            }
        }
        /*
        stage('Stop Test App'){
         #   steps {
          #      powershell(script: """
           #     docker-compose down
            #    """)
            #}
        #}
        */
    }
}
