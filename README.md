# iOS-OurNote
&emsp;&emsp;我的笔记，一款轻量级、简易版的笔记应用。本质就是一款类似于印象笔记的笔记应用，这次分享这个入门级的小应用，大家相互学习学习。

## 1.项目介绍  
&emsp;&emsp;本笔记应用旨在于实现文字笔记，语音笔记，照片笔记等混合方式的笔记记录。用户通过手机号进行账号的注册，并且通过第三方短信接口进行验证。用户的数据目前都是存储在 [Bmob移动后端云](http://www.bmob.cn/) 这个第三方服务商上的。这极大简化了我们移动应用的开发成本，前期不用考虑太多服务器端的设计实现。基于这个实现机制下，我们实现了用户数据远程储存，用户更换设备之后还可以把数据同步导移动端。

## 2.开发之南
以下主要列出本应用还有待完善的部分。  
1）第三方短信验证接口的接入。目前登录尚未进行短信验证。   
2）应用目前主要实现了记录文字笔记，语音，照片等形式尚未实现。   
3）应用个人设置界面相关操作也有待完善。  

## 3.应用截图
1)登录注册     
<img src="https://github.com/lysongzi/iOS-OurNote/raw/master/Screenshots/SignIn.png" width="250px"/> 

<img src="https://github.com/lysongzi/iOS-OurNote/raw/master/Screenshots/SignOut.png" width="250px"/> 

2)主页面  
<img src="https://github.com/lysongzi/iOS-OurNote/raw/master/Screenshots/Index.png" width="250px"/> 

3)设置界面     
<img src="https://github.com/lysongzi/iOS-OurNote/raw/master/Screenshots/Settings.png" width="250px"/> 

<img src="https://github.com/lysongzi/iOS-OurNote/raw/master/Screenshots/Photo.png" width="250px"/> 
   
4)编辑界面  
<img src="https://github.com/lysongzi/iOS-OurNote/raw/master/Screenshots/Edit.png" width="250px"/> 

## 4.个人博客
林友松。一个逗比的开发者。  
Email：lysongzi.hnu@gmail.com   
博客地址：[lysongzi.com](http://lysongzi.com)
