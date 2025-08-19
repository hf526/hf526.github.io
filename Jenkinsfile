pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = 'your-name/hexo-blog'
        VOLUME_PATH = '/data/hexo-blog'
    }
    
    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${DOCKER_IMAGE} .'
            }
        }
        
        stage('Deploy Container') {
            steps {
                sh '''
                docker stop hexo-blog || true
                docker rm hexo-blog || true
                docker run -d \
                  --name hexo-blog \
                  -p 4000:4000 \
                  -p 80:80 \
                  -v ${VOLUME_PATH}:/app \
                  ${DOCKER_IMAGE}
                '''
            }
        }
    }
}