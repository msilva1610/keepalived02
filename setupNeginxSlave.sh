#!/usr/bin/env bash
# BEGIN ########################################################################
echo -e "-- ----------------- --\n"
echo -e "-- INICIO ${HOSTNAME} --\n"
echo -e "-- ----------------- --\n"
# BOX ##########################################################################
echo -e "-- Atualizando packages list\n"
sudo apt-get update -y -qq
# Instalar nginx and keepalived ##########################################################################
echo -e "-- Instalar nginx e keepalived\n"
sudo apt-get install nginx keepalived -y
echo -e "-- Criando index.html do MASTER\n"
# HTML #########################################################################
echo -e "-- Criando index.html file\n"
sudo cat > /var/www/html/index.html <<EOD
<html>
<head>
<title>${HOSTNAME}</title>
</head>
<body>
<h1>Hostname: ${HOSTNAME}</h1>
<p>Eu sou o NGINX SLAVE!</p>
</body>
</html>
EOD

# KEEPALIVED #########################################################################
echo -e "-- Criando keepalived.conf\n"
sudo cat > /etc/keepalived/keepalived.conf <<EOD
vrrp_script checknginx {
        script "pidof nginx"
        interval 2
        weight 2
}
 
vrrp_instance VRRP1 {
    state BACKUP
    interface enp0s8
    virtual_router_id 100
    priority 100
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass 9999
    }
    virtual_ipaddress {
        192.168.50.30/24
    }
    track_script {
        checknginx
    }
 
}
EOD

# Iniciar keepalived com o boot ################################################
echo -e "-- Iniciar keepalived com o boot\n"
sudo systemctl enable keepalived
sudo systemctl restart keepalived

# END ##########################################################################
echo -e "-- ----------- --"
echo -e "-- END NGINX SLAVE --"
echo -e "-- ----------- --"