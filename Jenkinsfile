pipeline {
    agent any

    environment {
        NEXUS_CREDENTIALS = 'nexus_credentials'  // Your Jenkins stored credentials ID
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Joshnaacsha/java-17-maven-project-josh.git', branch: 'master'
            }
        }

        stage('Build & Deploy to Nexus') {
            steps {
                script {
                    withCredentials([usernamePassword(
                        credentialsId: NEXUS_CREDENTIALS,
                        usernameVariable: 'NEXUS_USERNAME',
                        passwordVariable: 'NEXUS_PASSWORD'
                    )]) {
                        // Ensure the .m2 directory exists
                        sh 'mkdir -p $HOME/.m2'

                        // Write settings.xml with Nexus credentials
                        writeFile file: "$HOME/.m2/settings.xml", text: """
                            <settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
                                      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                                      xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
                                                          https://maven.apache.org/xsd/settings-1.0.0.xsd">
                              <servers>
                                <server>
                                  <id>nexus-snapshots</id>
                                  <username>${env.NEXUS_USERNAME}</username>
                                  <password>${env.NEXUS_PASSWORD}</password>
                                </server>
                              </servers>
                            </settings>
                        """

                        // Deploy to Nexus
                        sh 'mvn clean deploy'
                    }
                }
            }
        }
    }
}
