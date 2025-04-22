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

