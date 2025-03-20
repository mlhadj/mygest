# Projet Gestion des Équipements et Tests des IP Actives

## Présentation du Projet

Le projet **"Gestion des Équipements et Tests des IP Actives"** permet de gérer les équipements informatiques d'une organisation via une interface en ligne de commande (CLI). Il permet à l'utilisateur de :

- Voir les équipements présents
- Ajouter, supprimer des équipements et des types d'équipements dans une base de données MySQL.
- Tester la disponibilité des adresses IP associées aux équipements, en affichant si une IP est active ou non.
- Tester des IP et des ports TCP.
- Afficher les résultats avec des messages colorés et des effets visuels (grâce à figlet et lolcat) pour rendre l'expérience utilisateur plus amusante et interactive.
- Générer un fichier `.txt` de la base de données.

Le projet s'appuie sur une base de données MySQL avec deux tables principales : **Equipement** et **TypeE**.

## Code Source

### 1. Test des IP Actives

Ce script récupère toutes les adresses IP des équipements stockées dans une base de données MySQL et teste leur disponibilité via un `ping`. Les résultats sont affichés en couleur, avec un message personnalisé en utilisant `figlet` et `lolcat`.

```bash
#!/bin/bash

# Variables de connexion à la base de données
DB_USER="sio"
DB_PASS="btsinfo"
DB_NAME="MyGest"

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

2. Suppression d'Équipements et Types d'Équipements
Ce script permet à l'utilisateur de supprimer des équipements ou des types d'équipements de la base de données, en vérifiant au préalable si l'élément à supprimer existe.

#!/bin/bash

echo -e "GestParc" | figlet | lolcat
echo "1) Supprimer un équipement"
echo "2) Supprimer un type d'équipement"
echo "0) Quitter"
echo -e "Veuillez choisir une option :"
read choix
case $choix in
    1 )
        echo "Veuillez saisir l'ID de l'équipement à supprimer :" | lolcat
        read -p "->ID de l'équipement : " idEquip
        # Vérification si l'équipement existe dans la base de données
        equipementExiste=$(mysql -u sio -p'btsinfo' -D MyGest -se "SELECT COUNT(*) FROM Equipement WHERE id=$idEquip;")
        
        if [[ $equipementExiste -gt 0 ]]; then
            # Suppression de l'équipement
            mysql -u sio -p'btsinfo' -D MyGest -e "DELETE FROM Equipement WHERE id=$idEquip;"
            echo "Suppression en cours . . ." | lolcat
            sleep 1
            echo "Équipement supprimé avec succès !" | lolcat
            mysql -u sio -p'btsinfo' -D MyGest -e "SELECT * FROM Equipement;"
        else
            echo "Aucun équipement trouvé avec cet ID" | lolcat
        fi
        ;;
    2 )
        echo "Veuillez saisir l'ID du type d'équipement à supprimer :" | lolcat
        read -p "->ID du type d'équipement : " idType
        # Vérification si le type d'équipement existe dans la base de données
        typeExiste=$(mysql -u sio -p'btsinfo' -D MyGest -se "SELECT COUNT(*) FROM TypeE WHERE id=$idType;")
        
        if [[ $typeExiste -gt 0 ]]; then
            # Suppression du type d'équipement
            mysql -u sio -p'btsinfo' -D MyGest -e "DELETE FROM TypeE WHERE id=$idType;"
            echo "Suppression en cours . . ." | lolcat
            sleep 1
            echo "Type d'équipement supprimé avec succès !" | lolcat
            mysql -u sio -p'btsinfo' -D MyGest -e "SELECT * FROM TypeE;"
        else
            echo "Aucun type d'équipement trouvé avec cet ID" | lolcat
        fi
        ;;
    0 )
        echo "Merci et au revoir !" | lolcat
        ;;
esac

echo -e "Retour au menu" | figlet | lolcat
echo -e "Appuyez sur entrée pour continuer :"
read

Utilisation du Projet
Prérequis
Système Linux ou Unix (Ubuntu, Debian, etc.)
MySQL ou MariaDB installé : Le script nécessite une base de données MySQL pour stocker les informations sur les équipements et les types d'équipements.
figlet et lolcat installés : Ces outils sont utilisés pour personnaliser les messages dans le terminal.
Pour installer figlet et lolcat sur Ubuntu/Debian, vous pouvez utiliser la commande suivante :

sudo apt-get install figlet lolcat

Étapes d'Utilisation
Configurer la base de données :

Créez une base de données nommée MyGest.
Créez les tables Equipement et TypeE selon la structure décrite précédemment.
Télécharger ou créer le script :

Créez un fichier script, par exemple gestion_equipements.sh, et copiez-y le code source.
Rendre le script exécutable :

Exécutez la commande suivante pour rendre le script exécutable :

chmod +x gestion_equipements.sh

Exécution du script :

Lancez le script en utilisant la commande suivante :

./gestion_equipements.sh

Fonctionnalités du menu :
Test des IP Actives : Ce script teste la disponibilité des IP associées aux équipements et les affiche avec des couleurs (vert pour actif, rouge pour inactif).
Suppression d'un équipement ou d'un type d'équipement : Le menu permet de supprimer des équipements ou des types d'équipements de la base de données en entrant l'ID correspondant.
Retour au menu : Après chaque opération, le script vous permet de revenir au menu principal pour choisir une nouvelle action.
Conclusion
Ce projet est une manière simple de gérer les équipements et tester la disponibilité de leurs adresses IP tout en apportant une touche ludique avec figlet et lolcat. C'est un bon exemple de gestion d'équipements dans un environnement réseau avec une base de données MySQL.

