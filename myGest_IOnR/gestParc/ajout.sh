echo -e "GestParc" | figlet | lolcat
echo "1) Ajouter un équipement"
echo "2) Ajouter un type d'équipement"
echo "0) Quitter"
echo -e "Veuillez choisir une option :"
read choix
case $choix in
	1 )
		echo "Veuillez saisir les informations suivantes :" | lolcat
		read -p "->Nom : " nom 
		while true;do
		read -p "->Adresse MAC : " mac 
		if [[ $mac =~ ^([0-9A-Fa-f]{2}[:\-]){5}[0-9A-Fa-f]{2}$ ]]; then
			break
		else
			echo "Votre addresse MAC semble incorrecte"
		fi
		done
		while true;do
		read -p "->Adresse IP : " ip  
		if [[ $ip =~ ^(25[0-5]|2[0-4][0-9]|1?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|1?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|1?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|1?[0-9][0-9]?)$ ]]; then
			break
		else
			echo "votre addresse ip semble incorrecte"
		fi
		done
		while true;do
		read -p "->Masque CIDR (ex:24) : " cidr 
		if [[ $cidr =~ ^(3[0-2]|[12]?[0-9])$ ]]; then
			break
		else
			echo "votre masque cidr semble incorrecte"
		fi
		done
		echo "veuillez selectionner un type parmis les suivants :"
		mysql -u sio -p'btsinfo' -D MyGest -se "SELECT * FROM TypeE;" | tail +1 | awk '{printf $1 "-" $2 " "}'		
		read -p " (ex:4 pour routeur) : " idt 
		bon_mot=$(mysql -u sio -p'btsinfo' -D MyGest -se "SELECT libelle FROM TypeE WHERE id=$idt;")
		
		if [[ -z "$bon_mot" ]]; then
			echo "la valeur saisie est incorrecte"
		else
			echo "le type choisie est : $bon_mot"
		fi
		mysql -u sio -p'btsinfo' -D MyGest -e "INSERT INTO Equipement (id, nom, adMAC, adIP, CIDR, idT) VALUES (NULL, '$nom', '$mac', '$ip', '$cidr', '$idt');"
		sleep 1
		echo "Ajout en cours . . ." | lolcat
		echo "Ajout effectuer avec succés " |lolcat	
		mysql -u sio -p'btsinfo' -D MyGest -e "SELECT * FROM Equipement;"
		;;
	2 )
		echo "Saisissez votre type d'équipement"
		read typeE
		echo -e "Récapitulatif de la requete \n INSERT INTO TypeE (id,libelle) VALUES (NULL, '$typeE')"
		mysql -u sio -p'btsinfo' -D MyGest -e "INSERT INTO TypeE (id,libelle) VALUES (NULL, '$typeE');"
		echo "Ajout en cours . . ." | lolcat
		sleep 1
		mysql -u sio -p'btsinfo' -D MyGest -e "SELECT * FROM TypeE;"
		sleep 1
		;;
	0 )
		echo "merci au revoir"
		;;
esac


echo -e "Retour au menu" | figlet | lolcat
echo -e "appuyer sur entrée pour continuer :"
read 
