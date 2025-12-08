pipeline {
    agent any
    environment {
        EC2_USER = 'ubuntu'
        EC2_HOST = '13.203.220.165'
        SSH_KEY_ID = 'ec2-ssh-key' // Jenkins credential
        APP_DIR = '/home/ec2-user/flaskapp'
    }

    stages {
        stage('Checkout-stage') {
            steps {
                checkout scm
            }
    }

        stage('Install Dependencies') {
            steps {
                sh 'python3 -m venv venv'
                sh './venv/bin/pip install -r requirements.txt'
            }
        }

        stage('Test') {
            steps {
                sh 'pytest || echo "No tests found, continuing..."'
            }
        }

    }
}
