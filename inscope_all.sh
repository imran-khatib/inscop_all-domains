#!/bin/bash

get_in_scope_domains(){
	mkdir -p In_scope_domains/	   	
	#CHAOS-domains
	curl -sL https://github.com/projectdiscovery/public-bugbounty-programs/raw/master/chaos-bugbounty-list.json | jq -r '.programs[].domains | to_entries | .[].value' | anew -q In_scope_domains/chaos-bugbounty-list.txt
	#Hackerone_Domains
	curl -sL https://github.com/arkadiyt/bounty-targets-data/blob/master/data/hackerone_data.json?raw=true | jq -r '.[].targets.in_scope[] | [.asset_identifier, .asset_type] | @tsv' | anew -q In_scope_domains/hackerone_data.txt
	#BUgcrowd_Domains
	curl -sL https://github.com/arkadiyt/bounty-targets-data/raw/master/data/bugcrowd_data.json | jq -r '.[].targets.in_scope[] | [.target, .type] | @tsv' | anew -q In_scope_domains/bugcrowd_data.txt 
	#Intigriti_Domains
	curl -sL https://github.com/arkadiyt/bounty-targets-data/raw/master/data/intigriti_data.json | jq -r '.[].targets.in_scope[] | [.endpoint, .type] | @tsv' | anew -q In_scope_domains/intigriti_data.txt
	#Hackproof_Domains
	curl -sL https://github.com/arkadiyt/bounty-targets-data/raw/master/data/hackenproof_data.json | jq -r '.[].targets.in_scope[] | [.target, .type, .instruction] | @tsv' | anew -q In_scope_domains/hackenproof_data.txt
	#YesWeHack_Domains
	curl -sL https://github.com/arkadiyt/bounty-targets-data/raw/master/data/yeswehack_data.json | jq -r '.[].targets.in_scope[] | [.target, .type] | @tsv' | anew -q In_scope_domains/yeswehack_data.txt
	#Federacy_Programs
	curl -sL https://github.com/arkadiyt/bounty-targets-data/raw/master/data/federacy_data.json | jq -r '.[].targets.in_scope[] | [.target, .type] | @tsv' | anew -q In_scope_domains/federacy.txt
	
}
get_in_scope_domains

open_inscope_domains(){
		

echo "Which Inscope Items  would you like?"

options=("Chaos" "Hackerone" "Intigriti" "Bugcrowd" "Hackenproof" "Federacy" )

echo -e "\e[1;33m ******* Wait \e[5m\e[96m Finding \e[25m\e[1;33m**** in_scope Domains **** \e[0m"
		
select opt in "${options[@]}" 

do

case $opt in
        "Chaos")
		  
		cat ~/my-recon/In_scope_domains/chaos-bugbounty-list.txt
		;;	
		"Bugcrowd") 
		cat ~/my-recon/In_scope_domains/bugcrowd_data.txt 
		;;
		"Hackerone")
		cat ~/my-recon/In_scope_domains/hackerone_data.txt
		;;
		"Intigriti")
		cat ~/my-recon/In_scope_domains/intigriti_data.txt
		;;
		"Hackenproof")
		cat ~/my-recon/In_scope_domains/hackenproof_data.txt
		;;
		"Federacy")
		cat ~/my-recon/In_scope_domains/federacy.txt
		;;
		# Matching with invalid data
		*)
		echo "Invalid entry."
		break
		;;
		esac
		done

}
open_inscope_domains

finish(){
	echo -e "\e[1;33m ******* The \e[5m\e[96m **** in_scope Domains **** \e[25m\e[1;33m **** Finished **** \e[0m" 

}
finish