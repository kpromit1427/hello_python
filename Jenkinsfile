pipeline {
    agent {
        dockerfile {
            filename 'Dockerfile'
            dir '.' // assuming Dockerfile is in repo root
        }

    }

    environment {
        EC2_USER = 'ec2-user' // or 'ubuntu'
        EC2_HOST = 'your.ec2.ip.address'
        SSH_KEY_ID = 'ec2-ssh-key' // Jenkins credential ID
        APP_DIR = '/home/ec2-user/flaskapp'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/kpromit1427/hello_python.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'python -m venv venv'
                sh './venv/bin/pip install -r requirements.txt'
            }
        }

        stage('Test') {
            steps {
                sh './venv/bin/python -m unittest discover'
            }
        }

        stage('Deploy to EC2') {
            steps {
                sshagent (credentials: [env.SSH_KEY_ID]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ${EC2_USER}@${EC2_HOST} '
                        mkdir -p ${APP_DIR}
                    '
                    scp -r * ${EC2_USER}@${EC2_HOST}:${APP_DIR}/
                    ssh ${EC2_USER}@${EC2_HOST} '
                        cd ${APP_DIR} &&
                        python3 -m venv venv &&
                        source venv/bin/activate &&
                        pip install -r requirements.txt &&
                        pkill gunicorn || true &&
                        nohup gunicorn -b 0.0.0.0:5000 app:app > gunicorn.log 2>&1 &
                    '
                    """
                }
            }
        }
    }
}
