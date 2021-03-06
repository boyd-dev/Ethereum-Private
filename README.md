# Ethereum Private Network with Docker

Geth v1.8.23(Xircus)를 도커 컨테이너로 만들어서 이더리움 로컬 Private Blockchain을 구성하고 [Ethstats](https://ethstats.net/)처럼 노드 모니터링도 함께 적용합니다. Private에 적합하도록 PoW가 아닌 <b>PoA(Clique)</b>로 특정 노드(sealer)에서 블록을 생성합니다(생성주기 5초).  


### Dockerfile

Dockerfile은 각각 ubuntu-xenial 이미지로부터 만들어졌습니다.

* eth-node  
Geth v1.8.23 이미지입니다. genesis.json, 블록 생성계정(sealer), 블록 sign을 위해 패스워드 파일 등이 이미지 생성에 필요합니다. puppeth과 geth account를 통해 미리 준비합니다.

* eth-netstats  
Node.js로 구현된 서버입니다. 노드 모니터링 화면을 제공하는 이미지입니다. 이더리움 [위키](https://github.com/ethereum/wiki/wiki/Network-Status)와 <a href="https://medium.com/@javahippie/building-a-local-ethereum-network-with-docker-and-geth-5b9326b85f37">다음 글</a>을 참고하시기 바랍니다.😁

* eth-net-intelligence  
등록된 노드(app.json에 설정)에 접속하여 정보를 수집하고 웹소켓을 통해 eth-netstats으로 전달하는 서버 이미지입니다. 역시 <a href="https://medium.com/@javahippie/building-a-local-ethereum-network-with-docker-and-geth-5b9326b85f37">다음 글</a>을 참고하시기 바랍니다.

### docker-compose.yml

docker-compose를 통해 부트노드, Sealer노드(1개), 일반노드(2개), 모니터링 서버, 화면 서버를 모두 실행합니다. Dockerfile을 통해 만들어진 이미지를 컨테이너에 담아 순차적으로 실행합니다.

### 사용법

1) 각 디렉토리에 있는 Dockerfile을 사용하여 다음과 같이 이미지를 생성하십시오. <b>빌드하는데는 시간이 걸립니다.</b> 

```
docker build -t eth-pri:1.0 .
```

생성된 이미지 이름을 docker-compose.yml에서 참조합니다. 예를 들어 생성된 이미지는 다음과 같이 확인할 수 있습니다.

```
docker images
```

|REPOSITORY|TAG|IMAGE ID|CREATED|SIZE|
|---|---|---|---|---|
|eth-intelli|latest|bec72719e550|2 hours ago|520MB|
|eth-stats|latest|b49b42609e90|2 hours ago|699MB|
|eth-pri|1.0|e56970c701bb|2 hours ago|451MB|

2) docker-compose를 실행하여 컨테이너를 생성하고 Private network를 구성합니다(docker-compose.yml이 있는 디렉토리에서 실행). 종료할 때는 docker-compose stop을 실행하면 됩니다.

```
docker-compose up
```

3) localhost:3000에 접속하여 노드들이 sync되는지 확인하십시오.

<img src="https://github.com/boyd-dev/Ethereum-Private/blob/master/stats.PNG" width="720"/>

4) 노드 컨테이너에 접속하려면 다음과 같이 쉘을 실행하십시오.

```
docker exec -it eth-node1 /bin/bash
```

5) 컨테이너에 접속한 후 geth attach로 자바스크립트 콘솔을 사용하려면 다음과 같이 할 수 있습니다(데이터 디렉토리는 /root/edu입니다).

```
root@fb7e4f887c80:~# geth attach ipc:/root/edu/geth.ipc
```

 
