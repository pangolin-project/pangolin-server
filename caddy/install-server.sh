#!/bin/bash
DISTRO='unknown'
PM='yum'
DOWNLOAD_FILE=caddy-x86_64-linux.tar.gz
DOWNLOAD_FILE_TAG=vpg1.0.2
DOWNLOAD_URL=https://github.com/pangolin-project/pangolin-server/releases/download/${DOWNLOAD_FILE_TAG}/${DOWNLOAD_FILE}
CONFIG_FILE=./Caddyfile
START_SCRIPT_FILE=./start_proxy.sh

function Get_Dist_Name()
{	
    if grep -Eqi "CentOS" /etc/issue || grep -Eq "CentOS" /etc/*-release; then
        DISTRO='CentOS'
        PM='yum'
    elif grep -Eqi "Red Hat Enterprise Linux Server" /etc/issue || grep -Eq "Red Hat Enterprise Linux Server" /etc/*-release; then
        DISTRO='RHEL'
        PM='yum'
    elif grep -Eqi "Aliyun" /etc/issue || grep -Eq "Aliyun" /etc/*-release; then
        DISTRO='Aliyun'
        PM='yum'
    elif grep -Eqi "Fedora" /etc/issue || grep -Eq "Fedora" /etc/*-release; then
        DISTRO='Fedora'
        PM='yum'
    elif grep -Eqi "Debian" /etc/issue || grep -Eq "Debian" /etc/*-release; then
        DISTRO='Debian'
        PM='apt-get'
    elif grep -Eqi "Ubuntu" /etc/issue || grep -Eq "Ubuntu" /etc/*-release; then
        DISTRO='Ubuntu'
        PM='apt-get'
    elif grep -Eqi "Raspbian" /etc/issue || grep -Eq "Raspbian" /etc/*-release; then
        DISTRO='Raspbian'
        PM='apt-get'
    else
        DISTRO='unknown'
    fi
}


## Error
function red(){
    echo -e "\033[31m\033[01m[ $1 ]\033[0m"
}

## warning
function yellow(){
    echo -e "\033[33m\033[01m[ $1 ]\033[0m"
}



Get_Dist_Name 
echo "you server distribution version  is ${DISTRO}"

type wget >/dev/null 2>&1

if [[ $? -ne 0 ]]; then
	echo "wget is not install, install it first!!"
	`${PM} install -y wget`
	if [[ $? -ne 0 ]]; then
	    red "install wget failed. please install wget manually, then run scripts again"
	    exit -1
	fi

fi

rm -f ${DOWNLOAD_FILE}

echo "### start download caddy server into current directory..."
wget ${DOWNLOAD_URL} 
if [[ $? -ne 0 ]]; then
	red "down caddy failed ${DOWNLOAD_URL}"
	exit -1
fi

echo "### download caddy server finished"

type netstat >/dev/null 2>&1

if [[ $? -ne 0 ]]; then
	${PM} install -y netstat
	if [[ $? -ne 0 ]]; then
		red "install netstat command failed, please install it manually"
		exit -1
	fi

fi
netstat -anpt | grep 443  | grep LISTEN > /dev/null  2>&1
if [[ $? -eq 0  ]];then
	red "443 port is used by other programs. please stop it then run scripts again!!!!"
	exit -1
fi

read -p "please input your domain:" DOMAIN
read -p "please input your email:" EMAIL

DOMAIN_LEN=`echo -n ${DOMAIN} | wc -c`



if [[ ${DOMAIN_LEN} -eq 0 ]]; then
	red "domain is empty, please input domain"
	exit -1
fi


yellow "make sure!!  your 443 port is open and not being used by other programs"



PASSWORD=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1`

ADMIN_PORT=`date +%s`
ADMIN_PORT=$((${ADMIN_PORT} % 60000))

ADMIN_USER=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1`
ADMIN_USER="admin${ADMIN_USER}"
ADMIN_PWD=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1`
PROXY_USER=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 4 | head -n 1`
PROXY_USER="proxy${PROXY_USER}"


touch ${CONFIG_FILE}

echo  "${DOMAIN}:443 {" > ${CONFIG_FILE}
echo  "    root ./" >> ${CONFIG_FILE}
echo  "    gzip " >> ${CONFIG_FILE}
echo  "    log stdout ">> ${CONFIG_FILE}
echo  "    forwardproxy {" >> ${CONFIG_FILE}
echo  "        basicauth ${PROXY_USER} ${PASSWORD}" >> ${CONFIG_FILE}
echo  "        adminport ${ADMIN_PORT}" >> ${CONFIG_FILE}
echo  "        adminuser ${ADMIN_USER}" >> ${CONFIG_FILE}
echo  "        adminpwd  ${ADMIN_PWD}" >> ${CONFIG_FILE}
echo  "        hide_ip" >> ${CONFIG_FILE}
echo  "        acl {" >> ${CONFIG_FILE}
echo  "               deny localhost" >> ${CONFIG_FILE}
echo  "            }" >> ${CONFIG_FILE}
echo  "    }" >> ${CONFIG_FILE}
echo  "}" >> ${CONFIG_FILE}


cat ${CONFIG_FILE} > Caddyfile.sample

type base64 >/dev/null 2>&1

if [[ $? -ne 0 ]];then
   ${PM} -y install base64
   if [[ $? -ne 0 ]];then
	   red "install base64 command tools failed, pls install it manually"
	   exit -1
   fi
fi

SUFFIX=`echo -n "${PROXY_USER}:${PASSWORD}" | base64`

function green(){
    echo -e "\033[32m $1 \033[0m"
}


touch ${START_SCRIPT_FILE}
if [[ $? -ne 0 ]]; then
	red "create start scripts failed"
	exit -1
fi

echo "#!/bin/bash" > ${START_SCRIPT_FILE}
echo "./caddy -agree -type=http -log=stdout" >> ${START_SCRIPT_FILE}

chmod +x ${START_SCRIPT_FILE}

rm -f ./caddy

type tar >/dev/null 2>&1
if [[ $? -ne 0 ]]; then
	red "tar is not installed , please install it manully , then run script again"
	exit -1
fi

tar xvf ${DOWNLOAD_FILE}

yellow "please run start_proxy.sh to run proxy server and paste the green line blow to using client to connect this server!"
green "connect url is : hs://${SUFFIX}@${DOMAIN}:443/?pangolin=1&adp=${ADMIN_PORT}&adm=${ADMIN_USER}&pwd=${ADMIN_PWD}"




