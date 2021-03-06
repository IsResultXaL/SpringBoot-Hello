IMAGE_NAME=registry.cn-shenzhen.aliyuncs.com/caogen/springboot-hello
CONTAINER_NAME=springboot-hello
#容器id
CID=$(docker ps | grep "$CONTAINER_NAME" | awk '{print $1}')
#镜像id
IID=$(docker images | grep "$IMAGE_NAME" | awk '{print $3}')

#删除容器和镜像
delete(){
    if [ -n "$CID" ]; then
        echo "exist $CONTAINER_NAME container，CID=$CID,delete docker container ..."
        docker stop $CONTAINER_NAME
        docker rm $CONTAINER_NAME
        echo "$CONTAINER_NAME container delete success"
    fi

    if [ -n "$IID" ]; then
        echo "exist $IMAGE_NAME image，IID=$IID, ,delete docker image ..."
        docker rmi -f $IID
        echo "$IMAGE_NAME image delete success"
    fi
}

run(){
    delete
    docker login --username=test --password=test registry.cn-shenzhen.aliyuncs.com
    docker pull $IMAGE_NAME
    docker run --cap-add=SYS_PTRACE --name $CONTAINER_NAME -p 8080:8080 -e JAVA_OPTS='-XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=128m -Xms1024m -Xmx1024m -Xmn256m -Xss256k -XX:SurvivorRatio=8 -XX:+UseConcMarkSweepGC' -v /etc/localtime:/etc/localtime:ro -d  $IMAGE_NAME
}

#入口
run