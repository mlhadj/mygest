echo -e "GestParc" | figlet | lolcat
echo "chargement des données . . ." | lolcat
sleep 1
mysql -u sio -p'btsinfo' -D MyGest -e "SHOW TABLES" | tail -n +2 | while read table; do
    echo -e "\n$table" | lolcat
    echo "-----------------------------------" | lolcat
    mysql -u sio -p'btsinfo' -D MyGest -e "SELECT * FROM $table;" | column -t
    echo "-----------------------------------" | lolcat
done
sleep 1
echo -e "Retour au menu" | figlet | lolcat
echo -e "appuyer sur entrée pour continuer :"
read 
