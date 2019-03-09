# Ethereum Private Network with Docker

geth 1.8.23(Xircus)를 도커 컨테이너로 만들어서 이더리움 로컬 Private Blockchain을 구성하고 Ethstats을 사용하여 노드 모니터링도 함께 적용해보았습니다. Private이므로 PoW가 아닌 PoA(이더리움 Clique)로 특정 노드에서 블록을 생성합니다.  


**Dockerfile**

Dockerfile은 각각 ubuntu-xenial 이미지로부터 만들어졌습니다.

1) eth-node  
geth 1.8.23 이미지입니다. genesis.json, 블록 생성계정(sealer), 블록 sign을 위해 패스워드 파일 등이 이미지 생성에 필요합니다. puppeth과 geth를 통해 미리 준비합니다.

2) eth-netstats  
Node.js로 구현된 서버입니다. 노드 모니터링 화면을 제공하는 이미지입니다. <a href="https://medium.com/@javahippie/building-a-local-ethereum-network-with-docker-and-geth-5b9326b85f37">다음 글</a>을 참고하시기 바랍니다.

3) eth-net-intelligence  
등록된 노드에 접속하여 정보를 수집하여 eth-netstats에 웹소켓을 통해 전달하는 서버 이미지입니다. 역시 <a href="https://medium.com/@javahippie/building-a-local-ethereum-network-with-docker-and-geth-5b9326b85f37">다음 글</a>을 참고하시기 바랍니다.

**docker-compose.yml**

docker-compose를 통해 부트노드, Sealer노드(1개), 일반노드(2개), 모니터링 노드, 화면 노드를 모두 실행합니다. Dockerfile을 통해 만들어진 컨테이너를 순차적으로 실행합니다.

**사용법**

1) 각 디렉토리에 있는 Dockerfile을 사용하여 이미지를 생성하십시오. docker-compose.yml에서 생성된 이미지 이름을 사용합니다. 예를 들어 생성된 이미지는 docker images 명령어로 다음과 같이 조회합니다.

```
docker images
```

|REPOSITORY|TAG|IMAGE ID|CREATED|SIZE|
|---|---|---|---|---|
|eth-intelli|latest|bec72719e550|2 hours ago|520MB|
|eth-stats|latest|b49b42609e90|2 hours ago|699MB|
|eth-pri|1.0|e56970c701bb|2 hours ago|451MB|

2) docker-compose를 실행하여 컨테이너를 생성하고 Private network를 구성합니다(docker-compose.yml이 있는 디렉토리에서 실행). 네트워크를 종료할 때는 docker-compose stop을 실행하면 됩니다.

```
docker-compose up
```

3) http://localhost:3000 에 접속하여 블록이 생성되고 3개의 노드가 모두 sync되는지 확인하십시오.

