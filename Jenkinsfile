pipeline {
    agent {
        label 'jenkins-agent'
    }

    options {
        timeout(time: 10, unit: 'MINUTES')
    }

    stages {
        stage("Check Docker version") {
            steps {
                sh '''
                  docker version
                  docker-compose version
                '''
            }
        }

        stage('Docker System Prune') {
            steps {
                sh 'docker system prune -a --volumes -f'
            }
        }


        // Start docker-compose selenium-hub
        stage('Start docker-compose') {
            steps {
                sh 'docker-compose -f docker-compose.yaml up -d --no-color'
                sh 'docker-compose ps'
            }
        }

        // Run API tests
        stage('API Automation') {
            steps {
                sh 'docker-compose -f docker-compose.yaml run -e TYPE="@API" api-test-service'
                //archive 'target/*'
            }
           // post {
           //     success {
                    // publish html
/*                    publishHTML ([
                            allowMissing         : false,
                            alwaysLinkToLastBuild: false,
                            keepAll              : true,
                            reportDir            : 'reports',
                            reportFiles          : 'api-test-report.html',
                            reportName           : 'API - E2E Tests Report'
                    ])*/

//                    publishHTML ([allowMissing: false,
//                                           alwaysLinkToLastBuild: false,
//                                           includes: '**/*',
//                                           keepAll: true,
//                                           reportDir: "reports/",
//                                           reportFiles: 'myreport.html',
//                                           reportName: 'My Reports',
//                                           reportTitles: ''])

/*                    publishHTML([allowMissing: false,
                                 alwaysLinkToLastBuild: false,
                                 keepAll: false,
                                 reportDir: "/home/ubuntu/workspace/jenkins-pipeline/reports",
                                 reportFiles: "index.html",
                                 reportName: 'HTML Report',
                                 reportTitles: '',
                                 useWrapperFileDirectly: true])*/

                }
/*                failure {
                    // publish html
                    publishHTML ([allowMissing: false,
                                           alwaysLinkToLastBuild: false,
                                           keepAll: true,
                                           reportDir: 'target/reports',
                                           reportFiles: 'myreport2.html',
                                           reportName: 'My Reports2',
                                           reportTitles: 'The Report2'])
                }*/
          //  }
       // }

        stage ('publish results') {
            steps {
                publishHTML([
                        allowMissing         : false,
                        alwaysLinkToLastBuild: true,
                        keepAll              : false,
                        reportDir            : "/home/ubuntu/workspace/jenkins-pipeline/reports",
                        reportFiles          : "index.html",
                        reportName           : 'HTML Report',
                        reportTitles         : ''
                ])
            }
        }

        // Run UI tests in parallel
        stage('UI Automated Tests Parallel run') {
            parallel {
                stage('UI Automation - Chrome') {
                    steps {
                        sh 'docker-compose -f docker-compose.yaml run -e TYPE="@UI" -e BROWSER="chrome" ui-test-service'
                    }
//                    post {
//                        always {
//                            success {
//                                // publish html
//                                publishHTML target: [
//                                        allowMissing         : false,
//                                        alwaysLinkToLastBuild: false,
//                                        keepAll              : true,
//                                        reportDir            : 'reports',
//                                        reportFiles          : 'index.html',
//                                        reportName           : 'UI - Chrome - E2E Tests Report'
//                                ]
//                            }
//                            failure {
//                                // publish html
//                                publishHTML target: [
//                                        allowMissing         : false,
//                                        alwaysLinkToLastBuild: false,
//                                        keepAll              : true,
//                                        reportDir            : 'reports',
//                                        reportFiles          : 'index.html',
//                                        reportName           : 'UI - Chrome - E2E Tests Report'
//                                ]
//                            }
//                        }
//                    }
                }
                stage('UI Automation - Firefox') {
                    steps {
                        sh 'docker-compose -f docker-compose.yaml run -e TYPE="@UI" -e BROWSER="firefox" ui-test-service'
                    }
//                    post {
//                        always {
//                            success {
//                                // publish html
//                                publishHTML target: [
//                                        allowMissing         : false,
//                                        alwaysLinkToLastBuild: false,
//                                        keepAll              : true,
//                                        reportDir            : 'reports',
//                                        reportFiles          : 'index.html',
//                                        reportName           : 'UI - Firefox - E2E Tests Report'
//                                ]
//                            }
//                            failure {
//                                // publish html
//                                publishHTML target: [
//                                        allowMissing         : false,
//                                        alwaysLinkToLastBuild: false,
//                                        keepAll              : true,
//                                        reportDir            : 'reports',
//                                        reportFiles          : 'index.html',
//                                        reportName           : 'UI - Firefox - E2E Tests Report'
//                                ]
//                            }
//                        }
//                    }
                }

            }
        }

        stage('Docker Teardown') {
            steps {
                /* Tear down docker compose */
                sh 'docker-compose down'

                /* Tear down all containers */
                sh 'docker-compose rm -sf'
            }
        }

        stage('Generate HTML report') {
            steps {
                cucumber buildStatus: 'UNSTABLE',
                        reportTitle: 'My report',
                        fileIncludePattern: '**/*.json',
                        trendsLimit: 10,
                        classifications: [
                                [
                                        'key'  : 'Browser',
                                        'value': 'Firefox'
                                ]
                        ]
            }
        }
    }

    post {
        always {
            sh 'docker-compose down --remove-orphans -v'
            sh 'docker-compose ps'
            //cleanWs()

//            cucumber buildStatus: 'UNSTABLE',
//                    reportTitle: 'My cucumber report',
//                    fileIncludePattern: '**/*.json',
//                    trendsLimit: 10,
//                    classifications: [
//                            [
//                                    'key': 'Browser',
//                                    'value': 'Chrome'
//                            ]
//                    ]
//        }
        }
    }
}









