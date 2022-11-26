# 一、搭建（能解锁的落地机）：安装dnsmasq+sniproxy
wget --no-check-certificate -O dnsmasq_sniproxy.sh https://raw.githubusercontent.com/myxuchangbin/dnsmasq_sniproxy_install/master/dnsmasq_sniproxy.sh && bash dnsmasq_sniproxy.sh -i
-f 快速安装
-i 正常安装

### 如果用ipv6解锁
修改配置/etc/sniproxy.conf 重启机器
resolver {
     mode ipv6_first
 }
ipv4_only   query for IPv4 addresses (default)
ipv6_only   query for IPv6 addresses
ipv4_first  query for both IPv4 and IPv6, use IPv4 is present
ipv6_first  query for both IPv4 and IPv6, use IPv6 is present

卸载
wget --no-check-certificate -O dnsmasq_sniproxy.sh https://raw.githubusercontent.com/myxuchangbin/dnsmasq_sniproxy_install/master/dnsmasq_sniproxy.sh && bash dnsmasq_sniproxy.sh -u

# 二、不能解锁的机器：安装dnsmasq，并修改dns为127.0.0.1
wget https://github.com/steamsv/steamsv.github.io/raw/master/unlock.sh && chmod +x unlock.sh
./unlock.sh DNS

### dnsmasq的分流配置：
/etc/dnsmasq.d/unlock.conf

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
systemctl stop dnsmasq
systemctl disable dnsmasq
systemctl restart dnsmasq
systemctl status dnsmasq

systemctl enable sniproxy
systemctl stop sniproxy
systemctl disable sniproxy
systemctl restart sniproxy
systemctl status sniproxy

加锁：
chattr +i /etc/resolv.conf

解锁
chattr -i /etc/resolv.conf

本机DNS：
cat /etc/resolv.conf
