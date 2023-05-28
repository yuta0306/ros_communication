[ifconfigの代わりにipを使う話](https://qiita.com/suzutsuki0220/items/dc72df23f1e1b1cda5f2)

`hostname`でipアドレスが取れる

```sh
hostname -I
172.17.0.1
```

## 通信用

~~poetryを使う．[how to install](https://python-poetry.org/docs/)~~

ros for python3

```sh
git clone https://github.com/ros/rospkg.git
cd rospkg
sudo python3 setup.py install
cd ..

git clone https://github.com/ros-infrastructure/catkin_pkg.git
cd catkin_pkg
sudo python3 setup.py install
cd ..

git clone https://github.com/ros-infrastructure/catkin.git
cd catkin
sudo python3 setup.py install
cd ..
```

python3におけるrosの扱いは，`rclpy`らしい．[参考](https://docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Writing-A-Simple-Py-Publisher-And-Subscriber.html)

よくわからないが，`rosrun usb_cam usb_cam_node`がうまくいかない時のコツ

```sh
roslaunch usb_cam usb_cam-test.launch
# ^Cで停止
rosrun usb_cam usb_cam_node  # もう一度回すとなぜか動く
```

[**ROS2 Humbleでros1_bridgeを使う方法**](https://docs.ros.org/en/humble/How-To-Guides/Using-ros1_bridge-Jammy-upstream.html)

**どうやらソースからROS2を入れないとダメらしい...**

1. [ROS2をソースからインストールする](https://docs.ros.org/en/humble/Installation/Alternatives/Ubuntu-Development-Setup.html)
   1. ~~この時`cd ~/ros2_humble/ && colcon build --symlink-install`はしないほうが良いと思われる．~~
   2. ~~ros2が実行できる環境にあると，`catkin`がinstallableではないらしい~~
2. [ros1_bridgeをインストールする](https://docs.ros.org/en/humble/How-To-Guides/Using-ros1_bridge-Jammy-upstream.html)
   1. やはりできない...ドキュメント通りだが．ros1_bridgeをdockerコンテナとして外に切り出した方がいいか

## ROSを消す

[https://qiita.com/yoshihiro1909/items/3b0274c5fe07c00e0cba](https://qiita.com/yoshihiro1909/items/3b0274c5fe07c00e0cba)

## 複数ノードで通信する方法

[https://qiita.com/tomoyafujita/items/07937a25bc48aa076056](https://qiita.com/tomoyafujita/items/07937a25bc48aa076056)