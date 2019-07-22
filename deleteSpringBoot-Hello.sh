IMAGE_NAME=registry.cn-shenzhen.aliyuncs.com/caogen/springboot_hello
IID=$(docker images | grep "$IMAGE_NAME" | awk '{print $3}')
run(){
    if [ -n "$IID" ]; then
        docker rmi -f $IID
    fi
}
run