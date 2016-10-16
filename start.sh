#!/bin/sh
echo "{"\"server\":\"$server\"","\"server_ipv6\":\"$server_ipv6\"","\"server_port\":\"$server_port\"","\"password\":\"$password\"","\"timeout\":120","\"udp_timeout\":60","\"method\":\"$method\"","\"protocol\":\"$protocol\"","\"obfs\":\"$obfs\"","\"dns_ipv6\":false","\"connect_verbose_info\":0","\"redirect\":\"\"","\"fast_open\":true"}" > /config.json
/usr/bin/supervisord
