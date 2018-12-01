
## pangolin-server 项目是什么？
pangolin-server是一个https的转发代理服务器。可以用于通过https的隧道协议来代理http的访问请求。可以和客户端（https://github.com/pangolin-project/pangolin-client-pc)   配合实现http代理的功能。
让客户端能够轻松实现匿名访问网站和访问无法访问的站点。

## 如何使用？
- 简单部署:
1. 进入caddy目录下。将install_server.sh的下载到您的linux服务器上(linux 可以使用命令: wget https://raw.githubusercontent.com/pangolin-project/pangolin-server/master/caddy/install-server.sh) 
2. 确保您使用的是root账户，通过命令: chmod +x ./install_server.sh 给脚本加上执行的权限
3. 然后运行该脚本 ./install_server.sh
4. 在脚本运行的时候会检查您服务器的443端口是否被占用。请确保443端口未被其他程序占用。并且443的防火墙端口开放
5. 在脚本运行的时候，会提示输入此服务器的域名。请确保该域名的正确性。并且此域名解析的ip的地址是您服务器的ip地址
6. 在输入您的email和域名后。在脚本的目录下会生成一个start_proxy.sh  请直接运行此脚本，如果未报错。则说明服务器运行成功，如果成功，通过ps axu | grep caddy会看到此服务器进程，通过netstat -anpt | grep 443 会发现此进程在监听此端口.
7. 在脚本运行完成后。还会打印一句: connect url is : hs://xxxxxxxx 类似的语句，此url就是您客户端用户链接此服务器的url。请将此url复制粘贴到您的客户的url输入框即可：
![](https://github.com/pangolin-project/pangolin-server/blob/master/images/url_sample.png)

## 基本原理
 ![](https://github.com/pangolin-project/pangolin-server/blob/master/images/proxy_basic.png)
