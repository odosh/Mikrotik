# jul/31/2025 09:05:24 by RouterOS 6.49.6
# software id = 8MRV-YDHT
#
# model = RB1100Dx4
# serial number = 91D309794A0D
/interface ethernet
set [ find default-name=ether2 ] name=ether2-SD
set [ find default-name=ether3 ] name=ether3-TK
set [ find default-name=ether4 ] name=ether4-SMPIA
set [ find default-name=ether6 ] name=ether6-Biznet
set [ find default-name=ether7 ] name=ether7-HSP
set [ find default-name=ether9 ] name=ether9-SMP
/interface list
add name=WAN
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ppp profile
add local-address=10.10.12.13 name=profile1-PPTP remote-address=10.10.12.14 \
    use-encryption=required
/queue simple
add limit-at=4096k/4096k max-limit=510M/510M name=Parent-all target="192.168.2\
    55.0/24,192.168.100.0/22,192.168.112.0/22,10.10.12.2/32,10.10.12.6/32,10.1\
    0.12.10/32"
add comment="ISP - HSP" disabled=yes limit-at=2048k/2048k max-limit=190M/190M \
    name=HSP parent=Parent-all target=192.168.255.0/24,192.168.100.0/22
add comment="ISP - Biznet" disabled=yes limit-at=2048k/2048k max-limit=\
    300M/300M name=Biznet parent=Parent-all target=192.168.112.0/22
/queue type
add kind=pcq name="pcq-download 3 Mb" pcq-classifier=dst-address pcq-rate=\
    3032
/snmp community
add addresses=::/0 name=alazhar
/system logging action
set 0 memory-lines=200
/user group
set full policy="local,telnet,ssh,ftp,reboot,read,write,policy,test,winbox,pas\
    sword,web,sniff,sensitive,api,romon,dude,tikapp"
add name=dude
/ip neighbor discovery-settings
set discover-interface-list=all
/interface list member
add interface=ether6-Biznet list=WAN
add interface=ether7-HSP list=WAN
/interface pptp-server server
set authentication=pap,chap,mschap1,mschap2
/ip address
add address=103.26.116.194/30 interface=ether7-HSP network=103.26.116.192
add address=117.102.82.18/29 interface=ether6-Biznet network=117.102.82.16
add address=10.10.12.5/30 interface=ether3-TK network=10.10.12.4
add address=10.10.12.1/30 interface=ether2-SD network=10.10.12.0
add address=10.10.12.9/30 interface=ether4-SMPIA network=10.10.12.8
/ip dns
set allow-remote-requests=yes cache-size=5120KiB max-concurrent-queries=\
    104800 servers=\
    203.142.83.222,103.247.216.202,203.142.84.222,103.247.216.203
/ip dns static
add address=104.16.249.249 disabled=yes name=cloudflare-dns.com
add address=104.16.249.249 disabled=yes name=cloudflare-dns.com
/ip firewall filter
add action=accept chain=forward comment=\
    "defconf: accept established,related,untracked" connection-state=\
    established,related,untracked
add action=drop chain=forward comment="defconf: drop invalid" \
    connection-state=invalid
add action=accept chain=input comment="defconf: accept ICMP" protocol=icmp
add action=accept chain=input comment="defconf: accept SSH Port" disabled=yes \
    dst-port=8222 protocol=tcp
add action=accept chain=input comment="defconf: accept WINBOX Port" dst-port=\
    8293 protocol=tcp
add action=accept chain=input comment="defconf: remote WINBOX router TKIA" \
    dst-port=8294 protocol=tcp
add action=accept chain=input comment="defconf: accept WINBOX Port" dst-port=\
    8295 protocol=tcp
add action=accept chain=input comment="defconf: accept WINBOX Port [cAP]" \
    dst-port=8296 protocol=tcp
add action=accept chain=input comment="defconf: accept Remote Ruckus" \
    dst-port=443 protocol=tcp
add action=accept chain=input comment="defconf: accept SNMP" dst-port=161 \
    protocol=udp
add action=accept chain=input comment="defconf: accept SNMP" dst-port=161 \
    protocol=tcp
add action=accept chain=input comment=\
    "defconf: accept established,related,untracked" connection-state=\
    established,related,untracked
add action=drop chain=input comment="defconf: drop DNS Request from WAN" \
    dst-port=53 in-interface-list=WAN protocol=udp
add action=drop chain=input comment="defconf: drop DNS Request from WAN" \
    dst-port=53 in-interface-list=WAN protocol=tcp
add action=drop chain=input comment="defconf: drop invalid" connection-state=\
    invalid
/ip firewall nat
add action=dst-nat chain=dstnat comment="defconf: DST router TK" dst-port=\
    8294 in-interface-list=WAN protocol=tcp to-addresses=10.10.12.6 to-ports=\
    8294
add action=dst-nat chain=dstnat comment="defconf: DST router SD" dst-port=\
    8295 in-interface-list=WAN protocol=tcp to-addresses=10.10.12.2 to-ports=\
    8291
add action=dst-nat chain=dstnat comment="defconf: DST router SMPIA" dst-port=\
    8296 in-interface-list=WAN protocol=tcp to-addresses=10.10.12.10 \
    to-ports=8291
add action=dst-nat chain=dstnat comment=PAT disabled=yes dst-port=8443 \
    in-interface-list=WAN protocol=tcp to-addresses=192.168.114.21 to-ports=\
    443
add action=dst-nat chain=dstnat comment="remote Ruckus" disabled=yes \
    dst-port=8043 in-interface-list=WAN protocol=tcp to-addresses=\
    192.168.114.43 to-ports=443
add action=dst-nat chain=dstnat comment="remote AP-LOKAL" disabled=yes \
    dst-port=80 in-interface-list=WAN protocol=tcp to-addresses=\
    192.168.100.28 to-ports=80
add action=dst-nat chain=dstnat comment="remote AP-LOKALhttp" disabled=yes \
    dst-port=443 in-interface-list=WAN protocol=tcp to-addresses=\
    192.168.100.28 to-ports=443
add action=dst-nat chain=dstnat comment="defconf: Ridirect DNS Lokal" \
    disabled=yes dst-port=53 protocol=tcp to-addresses=10.10.12.1 to-ports=53
add action=dst-nat chain=dstnat comment="defconf: Ridirect DNS Lokal" \
    disabled=yes dst-port=53 protocol=udp to-addresses=10.10.12.1 to-ports=53
add action=masquerade chain=srcnat comment="::: Masqured to Biznet" \
    out-interface=ether6-Biznet
add action=masquerade chain=srcnat comment="::: Masqured to HSP" \
    out-interface=ether7-HSP
/ip route
add comment="defconf: MARK ROUTE BIZNET" distance=1 gateway=117.102.82.17 \
    routing-mark="KE ISP 1"
add comment="defconf: MARK ROUTE HSP" distance=1 gateway=103.26.116.193 \
    routing-mark="KE ISP 2"
add comment="defconf: DEFAULT GATEWAY to BIZNET" distance=1 gateway=\
    117.102.82.17
add comment="defconf: DEFAULT GATEWAY to HSP" distance=2 gateway=\
    103.26.116.193
add comment="defconf: DST NETWORK SDIA 17" distance=1 dst-address=\
    192.168.100.0/22 gateway=10.10.12.2
add comment="defconf: DST NETWORK SMPIA 3" distance=1 dst-address=\
    192.168.112.0/22 gateway=10.10.12.10
add comment="defconf: DST NETWORK TKIA" distance=1 dst-address=\
    192.168.255.0/24 gateway=10.10.12.6
/ip route rule
add comment="defconf: ROUTER SD" dst-address=10.10.12.0/30 table=main
add comment="defconf: ROUTER TK" dst-address=10.10.12.4/30 table=main
add comment="defconf: SMPIA" dst-address=10.10.12.8/30 table=main
add dst-address=192.168.255.0/24 table=main
add dst-address=10.10.12.14/32 table=main
add dst-address=192.168.100.0/22 table=main
add dst-address=192.168.112.0/22 table=main
add comment="defconf: TK" src-address=192.168.255.0/24 table="KE ISP 2"
add comment="defconf: SD" src-address=192.168.100.0/22 table="KE ISP 2"
add comment="Router UTAMA - SD" src-address=10.10.12.2/32 table="KE ISP 2"
add comment="defconf: SMP" src-address=192.168.112.0/22 table="KE ISP 1"
add comment="Router UTAMA - TK" src-address=10.10.12.6/32 table="KE ISP 2"
add comment="Router UTAMA - SMPIA3" src-address=10.10.12.10/32 table=\
    "KE ISP 1"
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set ssh disabled=yes
set api disabled=yes
set winbox port=8293
set api-ssl disabled=yes
/ppp secret
add name=blackrouf password=P4ssw0rd profile=profile1-PPTP service=pptp
/snmp
set contact=subagti@al-azhar.or.id enabled=yes location="NOC Bintaro" \
    trap-community=alazhar trap-version=2
/system clock
set time-zone-name=Asia/Jakarta
/system identity
set name=@POP-Bintaro
/system logging
set 0 topics=info,!dhcp,!dns
add disabled=yes topics=dns
/system note
set show-at-login=no
