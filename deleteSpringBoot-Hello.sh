IMAGE_NAME=registry.cn-shenzhen.aliyuncs.com/caogen/springboot-hello
IID=$(docker images | grep "$IMAGE_NAME" | awk '{print $3}')
run(){
    if [ -n "$IID" ]; then
        echo "exist $IMAGE_NAME image，IID=$IID, ,delete docker image ..."
        docker rmi -f $IID
        echo "$IMAGE_NAME image delete success"
    fi
}
run