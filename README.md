## 環境

- Ubuntu Focal (20.04)
- ROS2 Foxy (公式がdockerを用意しているから)
- VMWare (テスト環境がmacosのため．linuxでないとカメラをdockerに共有するのが大変そう)

### UbuntuとROSvの競合

| Ubuntu | pseudo name | ROS1                          | ROS2    |
| ------ | ----------- | ----------------------------- | ------- |
| 18.04  | Bionic      | melodic                       | dashing |
| 20.04  | Focal       | noetic                        | foxy    |
| 22.04  | Jammy       | noetic? (not fficial support) | humble  |

**問題**
1. openface2_rosはmelodic
2. rosが公式に出しているbridgeのdockerイメージはfoxyのみ

優先は？
- openface2_rosを使いたいところ
- melodic-dashingのdockerイメージを作る？
- ?いや，[qiita](https://qiita.com/tomoyafujita/items/07937a25bc48aa076056)によると，ディストリビューションが変わっても通信ができている...

## 環境の準備

### VMWareのディスクを拡張する

**仮想マシンを立てる前に設定すれば，勝手に`/dev/sda3`が拡張されているっぽい**

[https://nashikachi.hatenablog.com/entry/2016/11/06/180235](https://nashikachi.hatenablog.com/entry/2016/11/06/180235)

流れとしては，`/dev/sda3`のパーティションを拡張して，けして，また作る感じ

サイトでの紹介の通りやって，最後だけ，`resize2fs`でコマンドを置換

```sh
resize2fs /dev/sda3
```

### dockerのインストール

```sh
# Install docker
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

ユーザに権限を与える


```sh
sudo usermod -g docker ubuntu
sudo /bin/systemctl restart docker.service
```

再起動して変更を有効化する

```sh
reboot
```

### oepnface2_rosのdockerコンテナを立てる

- Ubuntu bionic (18.04)
- ROS1 melodic

[ホスト上のファイルのマウントの仕方](https://qiita.com/Yarimizu14/items/52f4859027165a805630)

Xサーバの設定をマウントする．デバイスに/dev/video0 (Webカメラ)をマウントする．ディスプレイを環境変数に入れる．hostのネットワークを使う．

```sh
docker run --device /dev/video0 -e DISPLAY -v /tmp/.X11-unix/X0:/tmp/.X11-unix/X0 --network=host -it --rm tiryoh/openface2_ros:2.1
```

### ros2 foxyとros1をブリッジするコンテナを立てる

- Ubuntu Focal (20.04)
- ROS1 noetic
- ROS2 foxy

```sh
docker run -it --network=host --rm osrf/ros:foxy-ros1-bridge
```

[https://tomson784.github.io/ros_practice/ROS2/bridge_setup.html](https://tomson784.github.io/ros_practice/ROS2/bridge_setup.html)

~~使ってみた感じ使うまでに手順が多いため，`tiryoh/openface2_ros`のように，こちらでイメージを作成するべきかと~~

↑　作って公開済み

```sh
ros2 run ros1_bridge dynamic_bridge --bridge-all-topics
```

~~`--bridge-all-topics`をつければ，`openface2/*`を見つけられそう~~  
subscriberを書けば，勝手に`openface/*`は見つかる


ただし`openface2_ros`のコンテナにおいて，`[ERROR] [1685275601.993715180]: Compressed Depth Image Transport - Compression requires single-channel 32bit-floating point or 16bit raw depth images (input format is: rgb8).`が出てくる

### 対話モデル用環境ROS2

- Ubuntu 任意（テスト時Ubuntu Focal）
- ROS2 for Ubuntu ver（テスト時ROS2 foxy）

ホストOSでテストしてみた

ROS2のインストール

[https://docs.ros.org/en/foxy/Installation/Ubuntu-Install-Debians.html](https://docs.ros.org/en/foxy/Installation/Ubuntu-Install-Debians.html)


## `openface2_ros`の独自メッセージ定義 on マシン for ROS2

