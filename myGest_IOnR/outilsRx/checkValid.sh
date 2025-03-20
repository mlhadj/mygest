#!/bin/bash

# Variables de connexion à la base de données
DB_USER="sio"          # Remplace par ton utilisateur MySQL
DB_PASS="btsinfo"      # Remplace par ton mot de passe MySQL
DB_NAME="MyGest"       # Nom de ta base de données

# Codes de couleurs
GREEN='\033[0;32m'   # Couleur verte pour actif
RED='\033[0;31m'     # Couleur rouge pour inactif
NC='\033[0m'         # Réinitialiser la couleur (sans couleur)

# Afficher un message d'introduction avec figlet et lolcat
echo -e "Test des IP Actives" | figlet | lolcat
echo "Veillez patienter pendant que nous testons les IP..."

# Récupérer les adresses IP des équipements dans la base de données
ip_list=$(mysql -u $DB_USER -p$DB_PASS -D $DB_NAME -se "SELECT adIP FROM Equipement;")

# Vérifier si la requête a retourné des adresses IP
if [ -z "$ip_list" ]; then
    echo "Aucune adresse IP trouvée dans la base de données." | lolcat
    exit 1
fi

# Tester chaque adresse IP
for ip in $ip_list; do
    # Tester si l'adresse IP répond au ping
    ping -c 1 -W 2 "$ip" &>/dev/null

    # Vérifier le code de retour du ping
    if [ $? -eq 0 ]; then
        # IP active : afficher en vert
        echo -e "${GREEN}L'adresse IP $ip est active.${NC}" | lolcat
    else
        # IP inactif : afficher en rouge
        echo -e "${RED}L'adresse IP $ip n'est pas active.${NC}" | lolcat
    fi
done

# Message de fin avec figlet et lolcat
echo -e "Test terminé !" | figlet | lolcat
