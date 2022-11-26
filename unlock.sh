#!/bin/bash
#https://github.com/myxuchangbin/dnsmasq_sniproxy_install
#https://raw.githubusercontent.com/myxuchangbin/dnsmasq_sniproxy_install/master/sniproxy.conf

if grep -Eqi "CentOS" /etc/issue || grep -Eq "CentOS" /etc/*-release; then
    yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
    yum install bind-utils
    yum install -y dnsmasq
elif grep -Eqi "Debian" /etc/issue || grep -Eq "Debian" /etc/*-release; then
    apt-get update
    apt-get install dnsutils
    apt install -y dnsmasq
elif grep -Eqi "Ubuntu" /etc/issue || grep -Eq "Ubuntu" /etc/*-release; then
    apt-get update
    apt-get install dnsutils
    apt install -y dnsmasq
else
    echo "This script only supports CentOS, Ubuntu and Debian."
    exit 1
fi

if [ $? -eq 0 ]; then
    systemctl enable dnsmasq
	chattr -i /etc/resolv.conf
	
	if [ ! -f '/etc/resolv.conf' ];then
		cp -f /etc/resolv.conf /etc/resolv.conf.bak
	fi
	rm -f /etc/resolv.conf
    echo "nameserver 127.0.0.1" > /etc/resolv.conf
	chattr +i /etc/resolv.conf
cat > /etc/dnsmasq.d/unlock.conf <<EOF
domain-needed
bogus-priv
no-resolv
no-poll
all-servers
server=8.8.8.8
server=1.1.1.1
server=208.67.222.222
cache-size=2048
local-ttl=60
interface=*
address=/akadns.net/$1
address=/akam.net/$1
address=/akamai.com/$1
address=/akamai.net/$1
address=/akamaiedge.net/$1
address=/akamaihd.net/$1
address=/akamaistream.net/$1
address=/akamaitech.net/$1
address=/akamaitechnologies.com/$1
address=/akamaitechnologies.fr/$1
address=/akamaized.net/$1
address=/edgekey.net/$1
address=/edgesuite.net/$1
address=/srip.net/$1
address=/footprint.net/$1
address=/level3.net/$1
address=/llnwd.net/$1
address=/edgecastcdn.net/$1
address=/cloudfront.net/$1
address=/netflix.com/$1
address=/netflix.net/$1
address=/nflximg.com/$1
address=/nflximg.net/$1
address=/nflxvideo.net/$1
address=/nflxso.net/$1
address=/nflxext.com/$1
address=/hulu.com/$1
address=/huluim.com/$1
address=/hbonow.com/$1
address=/hbogo.com/$1
address=/hbo.com/$1
address=/amazon.com/$1
address=/amazon.co.uk/$1
address=/amazonvideo.com/$1
address=/crackle.com/$1
address=/pandora.com/$1
address=/vudu.com/$1
address=/blinkbox.com/$1
address=/abc.com/$1
address=/fox.com/$1
address=/theplatform.com/$1
address=/nbc.com/$1
address=/nbcuni.com/$1
address=/ip2location.com/$1
address=/pbs.org/$1
address=/warnerbros.com/$1
address=/southpark.cc.com/$1
address=/cbs.com/$1
address=/brightcove.com/$1
address=/cwtv.com/$1
address=/spike.com/$1
address=/go.com/$1
address=/mtv.com/$1
address=/mtvnservices.com/$1
address=/playstation.net/$1
address=/uplynk.com/$1
address=/maxmind.com/$1
address=/disney.com/$1
address=/disneyjunior.com/$1
address=/adobedtm.com/$1
address=/bam.nr-data.net/$1
address=/bamgrid.com/$1
address=/braze.com/$1
address=/cdn.optimizely.com/$1
address=/cdn.registerdisney.go.com/$1
address=/cws.conviva.com/$1
address=/d9.flashtalking.com/$1
address=/disney-plus.net/$1
address=/disney-portal.my.onetrust.com/$1
address=/disney.demdex.net/$1
address=/disney.my.sentry.io/$1
address=/disneyplus.bn5x.net/$1
address=/disneyplus.com/$1
address=/disneyplus.com.ssl.sc.omtrdc.net/$1
address=/disneystreaming.com/$1
address=/dssott.com/$1
address=/execute-api.us-east-1.amazonaws.com/$1
address=/js-agent.newrelic.com/$1
address=/xboxlive.com/$1
address=/lovefilm.com/$1
address=/turner.com/$1
address=/amctv.com/$1
address=/sho.com/$1
address=/mog.com/$1
address=/wdtvlive.com/$1
address=/beinsportsconnect.tv/$1
address=/beinsportsconnect.net/$1
address=/fig.bbc.co.uk/$1
address=/open.live.bbc.co.uk/$1
address=/sa.bbc.co.uk/$1
address=/www.bbc.co.uk/$1
address=/crunchyroll.com/$1
address=/ifconfig.co/$1
address=/omtrdc.net/$1
address=/sling.com/$1
address=/movetv.com/$1
address=/happyon.jp/$1
address=/abema.tv/$1
address=/hulu.jp/$1
address=/optus.com.au/$1
address=/optusnet.com.au/$1
address=/gamer.com.tw/$1
address=/bahamut.com.tw/$1
address=/hinet.net/$1
EOF

    systemctl restart dnsmasq
    echo "dnsmasq启动成功"
    echo ""
    echo "本机当前DNS"
    echo "---------------------"
    cat /etc/resolv.conf
    echo ""
    echo "备份DNS/etc/resolv.conf.bak"
    echo "---------------------"
    cat /etc/resolv.conf.bak
    echo "建议把系统默认DNS添加到/etc/dnsmasq.d/unlock.conf文件中"
else
    echo "dnsmasq安装失败, 请检查仓库状况"
fi
