FROM  alpine

ENV VER=1.7.0-alpha.8
ENV SNI=GameServer
ENV UUID=00000000-0000-0000-0000-000000000000
ENV IP=2606:4700:110:8902:3d32:3c3c:5855:e2f5
ENV PK=wEo+IAYlmilt1Wvk741LO+tr6i9DkXgiDbm8PmeNKX4=

RUN apk add --no-cache curl && curl -LO https://github.com/SagerNet/sing-box/releases/download/${VER}/sing-box-${VER}-linux-amd64v3.tar.gz&& tar zxvf sing-box-${VER}-linux-amd64v3.tar.gz && chmod +x sing-box-${VER}-linux-amd64v3/sing-box

RUN echo \{\"dns\":\{\"servers\":[\{\"tag\":\"dns\",\"address\":\"https://1.0.0.1/dns-query\",\"strategy\":\"prefer_ipv6\",\"detour\":\"wg\"\}]\},\"inbounds\":[\{\"type\":\"vless\",\"tag\":\"vless-in\",\"listen\":\"0.0.0.0\",\"listen_port\":10000,\"users\":[\{\"name\":\"sekai\",\"uuid\":\"$\{UUID\}\"\}],\"transport\":\{\"type\":\"httpupgrade\",\"host\":\"$\{SNI\}.onrender.com\",\"path\":\"/\"\}\}],\"outbounds\":[\{\"tag\":\"wg\",\"type\":\"wireguard\",\"server\":\"162.159.195.81\",\"server_port\":7559,\"local_address\":[\"172.16.0.2/32\",\"$\{IP\}/128\"],\"private_key\":\"$\{PK\}\",\"peer_public_key\":\"bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=\",\"mtu\":1420\}]\} >/sing-box-${VER}-linux-amd64v3/config.json

CMD nohup sing-box-${VER}-linux-amd64/sing-box run -c sing-box-${VER}-linux-amd64v3/config.json
