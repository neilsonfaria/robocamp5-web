pipeline {
   agent {
        docker {
            image 'python'
            args '--network=skynet'
        }
    }

    stages {
        stage('Build') {
            steps {
                echo 'Baixando as dependências do projeto'
                sh 'pip install -r requirements.txt'
            }
        }
        stage('Test') {
            steps {
                echo 'Executando testes de regressão'
                input(message: 'Aguarde!!!', ok: 'Prosseguir')
                sh 'robot -d ./logs -i login tests/'
            }
            post {
                always {
                    robot 'logs'
                }
            }
        }
        stage('UAT') {
            steps {
                echo 'Aprovação dos testes de aceitação'
            }    
        }
        stage('Production') {
            steps {
                echo 'WebApp Ok em produção!'
            }               
        }
    }
}
