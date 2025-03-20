#!/bin/bash

# Variables pour la connexion à la base de données
USER="sio"
PASSWORD="btsinfo"
DB="MyGest"

# Le nom du fichier généré
fichier_de_sortie="liste_ip.txt"

# Vérification de la connexion à MySQL
echo "Vérification de la connexion à la base de données MySQL..."
mysql -u $USER -p$PASSWORD -e "exit" &>/dev/null

# Si la connexion échoue
if [ $? -ne 0 ]; then
    echo "Échec de la connexion à la base de données. Vérifiez vos identifiants."
    exit 1
fi

# Récupération de toutes les adresses IP des équipements
echo "Récupération des adresses IP des équipements..."
mysql -u $USER -p$PASSWORD -D $DB -se "SELECT adIP FROM Equipement;" > $fichier_de_sortie

# Vérification si le fichier a été généré et contient des données
if [[ -s $fichier_de_sortie ]]; then
    echo "Le fichier $fichier_de_sortie a bien été généré avec les adresses IP."
else
    echo "Aucune adresse IP trouvée dans la base de données ou le fichier n'a pas pu être créé."
fi

