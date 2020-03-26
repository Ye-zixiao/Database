# **如何使用zip解压文件安装PostgreSQL**

## <font color=orange>一、下载软件</font>
首先通过这个链接下载最新的PostgreSQL的最新软件版本：[https://www.enterprisedb.com/download-postgresql-binaries](https://www.enterprisedb.com/download-postgresql-binaries)

## <font color=orange>二、具体安装步骤</font>
1、**将压缩文件解压到自己想要的文件中**

2、**初始化数据库**：

使用cmd在pqsql解压后的文件夹的bin文件夹目录输入命令：

`initdb -D data文件目录 -E UTF-8 --locale=chs -W`

    这些参数的意思为：

        -D设置默认数据库文件

        -U指定数据库用户
    
        -W要求两次设置输入用户密码

        --locale设置本地化语言

3、**启动数据库**：

`pg_ctl -D data文件目录 -l pgsql文件夹下直接生成一个日志文件logfile（这里是一个日志的目录） start`

例如：`pg_ctl -D d:\pgsql\data -l d:\pgsql\logfile.txt start`

4、**设置超级用户管理员**：

`createuser --superuser 自己想取的一个名字`

在默认情况下会以当前系统用户名作为用户

5、**链接数据库**：

`psql -h localhost -p 5432 -U 刚才取的用户名或者干脆不输入这句话用系统默认的 -d 数据库名称(默认一开始会有一个postgres)`

例如：`psql -h localhost -p 5432 -U yexin -d postgres`
（有些参数不是必要的）进入数据库之后使用\p推出数据库，当然下一步你想干嘛是你的事

6、**注册Windows服务**：
这样就可以在开机之后一直提供这个服务，不用每次去主动开启这个数据库服务（下面的操作需要管理员权限，仍然在bin这个文件目录下）

`pg_ctl register -N PostgreSQL -D data文件目录`

使用命令：`net start PostgreSQL`开启服务，使用net stop关闭

7、**环境变量设置**：

把`D:\pgsql\bin`这个路径放到系统路径PATH下，其他的如`D:\pgsql\data`和`D:\pgsql\lib`放到自己想要的环境变量中，这样就不用每次打开cmd就用cd找目录了

## <font color=orange>三、常见的关于数据库界面指令</font>

#### 链接数据库:

`pslq -h 主机地址 -p 端口号 -U 用户名 -d 数据库名`用于登录数据库

#### 以下用于登陆之后使用:

`\l *想要查找含有的关键字数据库*` 展示含有关键字的数据库，若没有*--*就是展示该账户下所有的数据库

![展示数据库](picture_source/l_select.png)
C:\Users\yexin\Desktop\数据库\SQL基础教程\picture_source
`\c 数据库名 用户名 主机地址 端口号`  用于切换到‘数据库名’指定的数据库

![切换数据库](picture_source\exchange_database.png)

`\d `  用于展示所有当前数据库中含有的表等关系

`\q `  退出当前数据库

## <font color=orange>四、创建超级用户并进行数据库文件导入导出</font>

创建超级用户，使用命令：

    createuser -P -s -U <联结用户名> -p 5432 <username>
        其中-P指出当前用户需用进行密码注册，-s指出当前用户是超级用户，-U是联结用户的参数，在psql中系统
        系统超级用户是postgres，所有的新创建的用户都是联结到它的（当然这种想法我仅仅是猜想的，不作为参
        考）；最后一个参数才是输入用户名


创建数据库，不过这个完全可以在进入用户后再创建：

    createdb -U <username> -E utf-8 -p 5432 <databasename>

导入数据库：

    psql -U <username> -f <文件路径，这个直接从文件管理器中复制粘贴就行了/...sql> -p 5432 <databasename>
        这里面的-f这些参数完全可以在psql --help中查看了解，文件路径最后也一定要到目标sql文件

导出数据库：

    psql -U <username> -f <文件路径.../somesome.sql> -p 5432 <databasename>
        其中文件路径最后一定要到某个sql文件否则不会运行成功的

#### 创建新用户的shell命令
<center>

![创建新用户的命令参数](picture_source\createuser.png)
</center>
