# 一、能解锁的落地机：安装sniproxy
wget --no-check-certificate -O dnsmasq_sniproxy.sh https://raw.githubusercontent.com/myxuchangbin/dnsmasq_sniproxy_install/master/dnsmasq_sniproxy.sh && bash dnsmasq_sniproxy.sh -fs

-is, --安装 SNI Proxy  
-fs, --快速安装 SNI Proxy  
-us, --卸载 SNI Proxy

### 如果用ipv6解锁
修改配置/etc/sniproxy.conf 重启机器  
resolver {  
     mode ipv6_first  
 }
 
ipv4_only：query for IPv4 addresses (default)  
ipv6_only：query for IPv6 addresses  
ipv4_first：query for both IPv4 and IPv6, use IPv4 is present  
ipv6_first：query for both IPv4 and IPv6, use IPv6 is present  

### 代理域名列表（白名单）
默认代理Netflix Hulu HBO等大部分流媒体域名，具体文件/etc/sniproxy.conf

# 二、不能解锁的机器：安装dnsmasq
wget --no-check-certificate -O unlock.sh https://raw.githubusercontent.com/bingotl/dns_unlock/main/unlock.sh && chmod +x unlock.sh  
./unlock.sh ip

ping netflix.com  
显示的是你的解锁机ip，那说明已经成功

### dnsmasq的分流配置文件（指定域名分流到解锁ip）  
/etc/dnsmasq.d/unlock.conf  
默认包含大部分流媒体网站

建议把分流文件的DNS，替换为系统原本的DNS（查看备份文件/etc/resolv.conf.bak）  
server=8.8.8.8  
server=1.1.1.1  
server=208.67.222.222  

### 不使用dnsmasq（卸载解锁）：
chattr -i /etc/resolv.conf  
cat > /etc/resolv.conf <<EOF  
nameserver 8.8.8.8  
nameserver 1.1.1.1  
EOF
               
systemctl stop dnsmasq  
systemctl disable dnsmasq

# 其他命令
systemctl enable dnsmasq  
systemctl stop dnsmasq && systemctl disable dnsmasq  
systemctl restart dnsmasq            
systemctl status dnsmasq  
         
systemctl enable sniproxy            
systemctl stop sniproxy && systemctl disable sniproxy              
systemctl restart sniproxy                     
systemctl status sniproxy

### 系统DNS相关命令
加锁DNS文件  
chattr +i /etc/resolv.conf

解锁DNS文件  
chattr -i /etc/resolv.conf

查看本机DNS  
cat /etc/resolv.conf
                             
使用dnsmasq需要把系统DNS设为127.0.0.1（脚本已包含）
                             
资料  
https://github.com/myxuchangbin/dnsmasq_sniproxy_install  
https://raw.githubusercontent.com/myxuchangbin/dnsmasq_sniproxy_install/master/sniproxy.conf
