#! /bin/bash

daemon="openvpn"
prog="openvpn-client"
conf_file="miet.ovpn"   # Config file path
distribution="noble"    # Release name

install_openvpn() {
	sudo apt install apt-transport-https curl;
	sudo mkdir -p /etc/apt/keyrings;
	sudo curl -sSfL https://packages.openvpn.net/packages-repo.gpg > ~/openvpn.asc
	sudo cp ~/openvpn,asc /etc/apt/keyrings/openvpn.asc
	sudo rm ~/openvpn.asc

	echo "deb [signed-by=/etc/apt/keyrings/openvpn.asc] https://packages.openvpn.net/openvpn3/debian $distrbution main" >> ~/openvpn3.list;
	sudo cp ~/openvpn3.list /etc/apt/sources.list.d/openvpn3.list
	sudo rm ~/openvpn3.list
	
	sudo apt update
	sudo apt install openvpn3
}

connect() {
    echo -n $"Starting $prog: "
	openvpn3 session-start --config $conf_file;
}

disconnect() {
    echo -n $"Stopping $prog: "
    session=$((openvpn3 sessions-list | grep "Path: ") | sed 's/^ *Path: //')
	openvpn3 session-manage --session-path $session --disconnect
}

session_list() {
    openvpn3 sessions-list
}

import_config() {
	openvpn3 config-import --config $conf_file
}