echo "Test d'une IP" | figlet | lolcat

while true; do
echo -e "Veuillez choisir une ip : " 
read ip

echo "Vérifons cette adresse ip ..." | lolcat
sleep 1

# Vérification via REGEX que l'adresse ip est valide
if [[ $ip =~ ^(25[0-5]|2[0-4][0-9]|1?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|1?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|1?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|1?[0-9][0-9]?)$ ]]; then
    echo "IP VALIDE : Testons la connectivité de cette addresse ip" | lolcat
    sleep 1
    echo "-----------------------------------------------"
    break
else
	    echo "Adresse IP invalide, merci de ré-essayer"
fi
done

ping $ip -c 4 | lolcat

echo "-----------------------------------------------"
echo "Retour au menu" | figlet | lolcat
echo "Appuyez sur entrée pour continuer ..."
read

