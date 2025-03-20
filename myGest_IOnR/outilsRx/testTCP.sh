echo "Test d'un Port" | figlet | lolcat 

while true; do
echo -e "Veuillez choisir une ip : " 
read ip

echo "Vérifons cette adresse ip ..." | lolcat
sleep 1

# Vérification via REGEX que l'adresse ip est valide
if [[ $ip =~ ^(25[0-5]|2[0-4][0-9]|1?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|1?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|1?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|1?[0-9][0-9]?)$ ]]; then
    echo "IP VALIDE : " | lolcat
    break
    
else
	    echo "Adresse IP invalide, merci de ré-essayer"
fi
done
while true; do
echo -e "Veuillez choisir un port : " 
read port

echo "Vérifons ce port ..." | lolcat
sleep 1

    if [[ "$port" =~ ^[0-9]+$ ]] && [ "$port" -ge 1 ] && [ "$port" -le 65535 ]; then
    	echo "Port valide : $port"
	sleep 1 
	echo "--------------------------------------------"
	nc -vz $ip $port
	break
    else
    	echo "Port invalide : $port"
    fi
done
echo "-----------------------------------------------"
echo "Retour au menu" | figlet | lolcat
echo "Appuyez sur entrée pour continuer ..."
read

