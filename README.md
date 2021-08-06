1. Build the docker image
```shell
docker build -t jenkins-git-plugin-bug .
```

2. Run docker container
```shell
docker run --rm \
    -v jenkins_home:/var/jenkins_home \
    -p 8080:8080 \
    --name jenkins-git-plugin-bug \
    jenkins-git-plugin-bug
```
