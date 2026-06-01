pipeline {

    agent any

    environment {
        AWS_REGION = 'us-east-1'
        ECR_REPO   = 'env-inspector'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                dir('app') {
                    sh '''
                        docker build \
                        -t ${ECR_REPO}:${BUILD_NUMBER} .
                    '''
                }
            }
        }

        stage('ECR Login') {
            steps {
                sh '''
                    ACCOUNT_ID=$(aws sts get-caller-identity \
                    --query Account \
                    --output text)

                    aws ecr get-login-password \
                    --region ${AWS_REGION} | docker login \
                    --username AWS \
                    --password-stdin \
                    ${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
                '''
            }
        }

        stage('Push Image') {
            steps {
                sh '''
                    ACCOUNT_ID=$(aws sts get-caller-identity \
                    --query Account \
                    --output text)

                    docker tag \
                    ${ECR_REPO}:${BUILD_NUMBER} \
                    ${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:${BUILD_NUMBER}

                    docker push \
                    ${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:${BUILD_NUMBER}
                '''
            }
        }

        stage('Update Helm Values') {
            steps {
                sh '''
                    sed -i.bak "s/tag:.*/tag: ${BUILD_NUMBER}/" \
                    app/helm/env-inspector/values.yaml

                    rm -f app/helm/env-inspector/values.yaml.bak

                    echo "Updated values.yaml"
                    grep -A2 "image:" app/helm/env-inspector/values.yaml
                '''
            }
        }

        stage('Commit Helm Changes') {
            steps {
                sh '''
                    git config user.email "jenkins@ci"
                    git config user.name "Jenkins"

                    git add app/helm/env-inspector/values.yaml

                    git diff --cached --quiet || \
                    git commit -m "Update image tag ${BUILD_NUMBER}"

                    git push origin main
                '''
            }
        }
    }

    post {

        success {
            echo 'Docker image pushed to ECR successfully.'
        }

        failure {
            echo 'Pipeline failed.'
        }

        always {
            cleanWs()
        }
    }
}