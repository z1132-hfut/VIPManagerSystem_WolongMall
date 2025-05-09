# VIPManagerSystem_WolongMall
该项目为web开发实践课程的个人作业，原题目是实现一张会员信息表的增删改查。我将其置于电商平台的环境下并增添了大量拓展功能，包括：
1.将用户分为普通用户和会员，实现多层次登录注册和访问。
2.管理员可以多条件组合查询会员，可以批量删除会员。
3.设计日志来记录管理员删除和查询会员等行为，管理员可以回看查询结果，可以撤回删除操作。
4.使用BCrypt对用户密码进行加密存储；实现预处理语句和参数查询防止sql注入攻击分析和解决问题

该项目用到的技术：Java，html，css，javascript，servlet，jsp，sql。

该项目为Maven项目，需在Tomcat服务器环境下运行，运行前需要先进行环境配置。
如何运行本项目：
一. 环境要求：
   - JDK 17+
   - Tomcat 9+
   - MySQL 8.0（或其他数据库）
二. 数据库设置：
   - 执行 `tips.txt` 里的sql代码初始化数据库。
   - 修改 `src/main/resources/dbinfo.properties` 中的数据库连接信息。输入你的账户名和密码。
三. 进行环境配置，可参考以下步骤：

1. 安装数据库软件
建议mysql  mysql-8.1.0-winx64（注意安装时，记住管理员root 帐号的密码，建议密码也设为 root。） 不同的数据库产品会有些区别，但管理员账号和密码要记住。

安装sqlyog、navcate（数据库的前端工具，直接用Idea也可以）
数据库mysql库的驱动程序： mysql-connector-java-8.0.29 （这是针对8.1版的，不同版本的驱动不一样。另外mac环境的驱动也不一样。）其他数据库产品要下载各自的驱动程序。

2. 安装JDK
 建议安装 JDK17及以上版本
（JDK路径的配置。
参照https://blog.csdn.net/2401_83413238/article/details/145382639 ）

3. 安装tomcat
 建议安装 apache-tomcat-9.0.100。 安装Tomcat前需要先安装JDK。

4. 安装开发环境
 建议使用idea
 官方下载。 https://www.jetbrains.com/zh-cn/idea/download/?section=windows 安装IntelliJ IDEA Ultimate 版
 破解： https://idea.medeming.com/idea/90.html  输入660503。

5. Idea 配置 web访问
根据博客完成web访问服务的设置。
https://www.cnblogs.com/Freeland98/p/18399995 

6. Idea 连接数据库
根据博客完成数据库的相关设置。两个博客类似，可以完成其中一个。
https://blog.csdn.net/m0_73181174/article/details/142536673 
https://blog.csdn.net/m0_73751121/article/details/139033763

7. 项目结构配置
（1） 进入项目结构，配置模块 Web（选择已有的web包）。 在Web工程里创建 工件。  可以把名称栏中的“:Web exploded”去掉。
（2） 在项目结构中，对项目打开设置功能。打开《依赖Dependencies》选项卡，添加 Tomcat 库。 
（3） 配置应用程序服务器。点开《当前文件Current File》旁边的下拉按钮，点击“编辑配置Edit Configurations”。 配置Tomcat界面。
在Tomcat配置界面中继续点击《部署Deploy》选项卡，打开部署配置界面，在《服务器启动时部署》中选择点击《+》按钮，然后在弹出的菜单中选择《工件Artifact》选项。
（4）在Web文件夹下WEB-INF文件添加两个空文件夹classes和lib
（5）进入项目结构。
点击Modules->Paths->Use module comple output path，从文件夹中搜索本项目的文件夹下面的web->WEB-INF下的classes(刚才设置的)，设置为依赖项。
（6）设置 Jar目录
点击Modules->Dependencies中的"+"号，选择JARS or Directories，选择刚才添加的lib空文件夹，并且选择Jar Directory
（7）成功后WEB-INF下面的classes文件夹会变黄
（8）添加库文件
往lib 目标添加3个文件。jsp-api.jar和servlet.api.jar以及JSDB数据库连接包mysql-connector-java-8.0.29.jar。（数据库连接包要根据安装的数据库产品和操作平台来选择，这是mysql 8.1的windows版驱动。）
（9）修改dbinfo.properties 文件中的 数据库连接参数。
（注意不同数据库产品的driver的设置。设置：用户帐户、密码、数据库名）

四. 启动 Tomcat，访问该项目。
