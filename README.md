# ZhanQi
战旗tv软件
###一言不合就上项目截图
![app首页.gif](http://upload-images.jianshu.io/upload_images/2011313-d374692531d54077.gif?imageMogr2/auto-orient/strip)

![app直播.gif](http://upload-images.jianshu.io/upload_images/2011313-053f092673e4b386.gif?imageMogr2/auto-orient/strip)

![
![app我的.gif](http://upload-images.jianshu.io/upload_images/2011313-f007e5671ac4686f.gif?imageMogr2/auto-orient/strip)
](http://upload-images.jianshu.io/upload_images/2011313-a6780ca00c292c80.gif?imageMogr2/auto-orient/strip)

9月份利用空余时间把app的主体部分写好了，不过直播界面存在一个很大的bug，下面截图上的两个重要的框架没导入，每次进入到这个直播拉流的界面时，程序就崩溃，全局断点一点作用都没有，前几天逛简书看到一哥们写的一个播放器，才知道自己的bug出在哪里。给自己一个教训吧
![bug截图.png](http://upload-images.jianshu.io/upload_images/2011313-1c4ba7dfed840601.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

接下来讲讲项目吧
##首页部分

![首页1.png](http://upload-images.jianshu.io/upload_images/2011313-bddf9207b46ec4f1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


![首页2.png](http://upload-images.jianshu.io/upload_images/2011313-c097b6598375ec63.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
首页有个地方稍微有点麻烦 ，collection的每一组cell都有组标题 ，而第一组的cell的组标题我是和轮播图放在一起，但是从接口返回的数据轮播的接口和下面每组cell的接口是两个接口，所以第一组cell的组头的数据是经过两个不同的网路请求得到的。（还有一个东西就是轮播图接口没有给我返回视频播放器的videoID，所以监听轮播图点击之后进到直播播放界面无法播放对应的视频）。还有一个就是百变娱乐组的cell数据里面也是没有videoID的，但是他返回的图片数据里面有对应的videoID字段，我经过vlc播放器测试是正确的，所以这一组我是截取图片字符串获取对应的videoID。

##直播栏
![视频.png](http://upload-images.jianshu.io/upload_images/2011313-f5e333cb6352f2d2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
这一栏没什么好说的，就一个数据加载，刷新功能。

##游戏栏和游戏子级

![游戏.png](http://upload-images.jianshu.io/upload_images/2011313-d3f100a67c53a6fa.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![游戏子级.png](http://upload-images.jianshu.io/upload_images/2011313-015ddfc5530ffeb4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这个也没啥讲的，不过要注意请求接口的字符串拼接，因为需要凭借对应的栏目ID去请求网络数据。

##我的界面

![我的.png](http://upload-images.jianshu.io/upload_images/2011313-f00a458a4722d5b8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

我的界面部分原版的app是下拉放大功能，我在此基础上加入了磨玻璃的老司机功能，给各位老司机一个惊喜（别BB了，快上车吧）

####这是发车钥匙，快上车吧，老司机们[项目链接](https://github.com/huangjianguohjg/ZhanQi)

别忘了帮本司机在github上点个星星。三克油！！！
