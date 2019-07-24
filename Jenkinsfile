#!groovy
  pipeline{
    agent any
    //定义仓库地址
    environment {
        REPOSITORY="https://github.com/IsResultXaL/SpringBoot-Hello"
        CONTAINER="springboot-hello"
        IMAGE="caogen/springboot-hello"
        VERSION="latest"
        USERNAME="test"
        PASSWORD="test"
        ALIYUN="registry.cn-shenzhen.aliyuncs.com"
    }

    stages {

        stage('获取代码'){
            steps {
                echo "start fetch code from git:${REPOSITORY}"
                // 清空当前目录
                deleteDir()
                // 拉取代码
                git "${REPOSITORY}"
            }
        }

        stage('Maven 构建'){
            steps {
                echo "start compile"
                // 重新打包
                sh 'mvn -Dmaven.test.skip=true -U clean install'
            }
        }

        stage('删除镜像'){
            steps {
                echo "start delete"
                // 删除镜像
                sh 'sh deleteSpringBoot-Hello.sh'
            }
        }

        stage('构建镜像'){
            steps {
                echo "start build image"
                // build镜像
                sh 'docker build -t ${IMAGE}:${VERSION} .'
            }
        }

        stage("上传镜像"){
            steps {
                echo "start push image"
                // push镜像
                sh 'docker login --username=${USERNAME} --password=${PASSWORD} ${ALIYUN}'
                sh 'docker tag ${IMAGE}:${VERSION} ${ALIYUN}/${IMAGE}:${VERSION}'
                sh 'docker push ${ALIYUN}/${IMAGE}:${VERSION}'
            }
        }

        stage('远程部署'){
            steps {
                echo "start service"
                echo "使用sshPublishers生成"
                sshPublisher(publishers: [sshPublisherDesc(configName: '测试机器', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '''cd /opt/test
                sh springboot-hello.sh''', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '/opt/test')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }

    }
}