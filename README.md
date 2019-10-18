# Mediaplayer
基于IJKPlayer的视频播放器，修改了ffmpeg解密过程，增加播放器UI上的一些功能 

##简介  
1. 该demo是基于IJKMediaFramework的视频播放器，主要播放HLS格式的视频
2. 由于GitHub的限制，IJKMediaFramework和m3u8资源文件请从网盘下载: https://pan.baidu.com/s/1ikYr6tzxNQnlnTUbUH0_tQ&shfl=shareset 提取码: wub6
3. IJKMediaFramework编译时增加定制化加密功能，如果有定制化需要，请自行打包IJK
4. 由于HLS视频不支持直接打开，需要本地启动一个HTTP服务，通过连接打开视频，这里使用CocoaHTTPServer来搭建HTTP服务
5. 部分情况下需要使用HTTPS协议，demo中使用的是自注册SSL证书，来实现HTTPS的访问
6. m3u8不支持客户端直接生成缩略图，视频缩略图请通过接口从服务器获取，改功能请自行实现  

## DEMO使用介绍  

将网盘下载的IJKMediaFramework引入工程，网盘下载的output文件夹下的视频导入工程对应的路径  

依赖包参照IJKMediaFramework的使用  

```
#     Build Phases -> Link Binary with Libraries -> Add: 

#           IJKMediaFramework.framework  
#           AudioToolbox.framework  
#           AVFoundation.framework  
#           CoreGraphics.framework  
#           CoreMedia.framework  
#           CoreVideo.framework  
#           libbz2.tbd  
#           libz.tbd  
#           MediaPlayer.framework  
#           MobileCoreServices.framework  
#           OpenGLES.framework  
#           QuartzCore.framework  
#           UIKit.framework  
#           VideoToolbox.framework  
#           libstdc++.tbd 
# 
```
