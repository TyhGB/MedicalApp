# MedicalApp

仿写一款App 橙邻橙里患者版 登陆界面 点击查看。（gif录制的时候太大修改了下，导致播放速度有点快）

![image](https://github.com/TyhGB/MedicalApp/blob/master/GIF图片/1.gif)

从原来app需要跟服务器交互，改成了 将用户的数据存储在了本地数据库中，以手机号作为唯一标志。可以进行登陆、注册、修改密码等操作。同时会限制手机号的长度、密码、用户名的长度等等。登陆成功会将用户信息以通知方式传递到下面。

# 第一个界面
![image](https://github.com/TyhGB/MedicalApp/blob/master/GIF图片/2.gif)
整体三块放在tableview的三个section中，顶部轮播图 采用第三方框架SDCycleScrollView，问医生，预约就诊等等截取不到原app的数据，所以无法写出来，报告咨询、健康自测也没有写，金币商城跟预约药品是两个webview，加载了我截取到的网址，同时在加载过程中在导航栏下面添加了加载的进度条。后面的所有webView都有这个进度条。
# 第二个界面
消息界面，因为原来的app没有消息，也没有截取到数据，所以不知道该写成什么样，没有写
# 第三个界面
![image](https://github.com/TyhGB/MedicalApp/blob/master/GIF图片/3.gif)
顶部轮播图，中间有5个button可以点击切换显示不同的信息，同时下面的一条紫色的线也会跟着移动。
# 第四个界面
实现了个人信息这块，可以修改头像，可以选择从相册选取，或者用摄像头拍摄（模拟器不能用摄像头）。可以修改昵称。
中间部分充值，订单等没有实现。
设置与帮助中可以修改密码，退出登陆等等。
联系客服弹出警告框显示号码。

项目使用cocoaPods 导入第三方框架。有AFNetworking、SDCycleScrollView、MJRefresh、SVProgressHUD、FMDB、SDWebImage几个。
