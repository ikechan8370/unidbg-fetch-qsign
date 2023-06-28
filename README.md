# unidbg-fetch-qsign

获取QQSign参数通过Unidbg，开放HTTP API。unidbg-fetch-sign最低从QQ8.9.33（不囊括）开始支持，TIM不支持。

> 多人使用请提高count值以提高并发量！！！

# 部署方法

## Jar部署

- 系统安装jdk或者jre，版本1.8或以上(仅1.0.3及更高版本，老版本要求jdk11)。如果报错找不到类，请尝试1.8或略靠近1.8的版本

- 解压后cd到解压目录，执行以下命令启动程序。<br>
```shell
bash bin/unidbg-fetch-qsign --host=0.0.0.0 --port=8080  --count=2 --library=txlib\8.9.63 --android_id=你的android_id
```
- 注意：你需要手动从apk安装包的`lib/arm64-v8a`目录中提取出[libfekit.so](txlib%2F8.9.63%2Flibfekit.so)、[libQSec.so](txlib%2F8.9.63%2FlibQSec.so)文件并存放至一个文件夹，然后使用`--library`指定该文件夹的`绝对路径`，结构例如：
> - your_dir<br>
>     - libfekit.so<br>
>     - libQSec.so<br>

> --library=`/home/your_dir`

- --host=监听地址
- --port=你的端口
 - --count=unidbg实例数量 (建议等于核心数) 【数值越大并发能力越强，内存占用越大】
 - --library=存放核心so文件的文件夹绝对路径

## Docker部署

[xzhouqd/qsign](https://hub.docker.com/r/xzhouqd/qsign)

## docker-compose部署

直接使用openjdk11启动服务

```yaml
version: '2'

services:
  qsign:
    image: openjdk:11.0-jdk
    environment:
      TZ: Asia/Shanghai
    restart: always
    working_dir: /app
    # 按需修改相关参数
    command: bash bin/unidbg-fetch-qsign --port=8080 --count=1 --library=txlib/8.9.63 --android_id=someandroidid
    volumes:
      # 当前目录放置qsign的解压包
      - ./unidbg-fetch-qsign:/app
      # 当前目录放置txlib
      - ./txlib:/app/txlib
    ports:
      # 按需调整宿主机端口
      - 8901:8080
```

# 使用API

### 原始energy

```kotlin
# http://127.0.0.1:8080/custom_energy?salt=[SALT HEX]&data=[DATA]
```

### sign

```kotlin
# http://127.0.0.1:8080/sign?uin=[UIN]&qua=V1_AND_SQ_8.9.63_4188_HDBM_T&cmd=[CMD]&seq=[SEQ]&buffer=[BUFFER]
```

### 登录包energy(tlv544)

下面这个只是个例子

```kotlin
# http://127.0.0.1:8080/energy?&version=6.0.0.2534&uin=1234567&guid=ABCDABCDABCDABCDABCDABCDABCDABCD&data=810_f
```
