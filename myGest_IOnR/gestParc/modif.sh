#!/bin/bash

echo "GestParc - Modifier les données"
echo "1) Modifier un équipement"
echo "2) Modifier un type"
echo "0) Quitter"
read -p "Veuillez choisir une option : " choix

case $choix in
1 )
  echo "Entrez l'ID de l'équipement pour la modification:"
  read -p "ID : " idEquip

  # Vérifier que l'équipement existe
  equipement=$(mysql -u sio -p'btsinfo' -D MyGest -se "SELECT nom FROM Equipement WHERE id=$idEquip;")
  if [ -z "$equipement" ]; then
    echo "Équipement non trouvé."
    exit 1
  fi

  echo "L'équipement actuel est : $equipement"
  echo "Que voulez-vous modifier ?"
  echo "1) Nom"
  echo "2) Adresse MAC"
  echo "3) Adresse IP"
  echo "4) Type d'équipement"
  read -p "Choisissez une option : " option

  case $option in
  1)
    read -p "Entrez un nouveau nom : " nom
    mysql -u sio -p'btsinfo' -D MyGest -e "UPDATE Equipement SET nom='$nom' WHERE id=$idEquip;"
    echo "Le nom à été modifié."
    ;;
  2)
    read -p "Entrez une nouvelle adresse MAC : " mac
    mysql -u sio -p'btsinfo' -D MyGest -e "UPDATE Equipement SET adMAC='$mac' WHERE id=$idEquip;"
    echo "L'Adresse MAC à été modifiée."
    ;;
  3)
    read -p "Entrez une nouvelle adresse IP : " ip
    mysql -u sio -p'btsinfo' -D MyGest -e "UPDATE Equipement SET adIP='$ip' WHERE id=$idEquip;"
    echo "L'Adresse IP à bien été modifiée."
    ;;
  4)
    echo "Sélectionnez le type d'équipement :"
    mysql -u sio -p'btsinfo' -D MyGest -se "SELECT * FROM TypeE;" 
    read -p "Entrez l'ID du type : " idType
    mysql -u sio -p'btsinfo' -D MyGest -e "UPDATE Equipement SET idT='$idType' WHERE id=$idEquip;"
    echo "Le Type d'équipement à bien été modifié."
    ;;
  *)
    echo "Option non disponible."
    ;;
  esac

  echo "Voici l'équipement mis à jour :"
  mysql -u sio -p'btsinfo' -D MyGest -e "SELECT * FROM Equipement WHERE id=$idEquip;"

  ;;
2 )
  echo "Entrez l'ID du type d'équipement à modifier :"
  read -p "ID : " idTypeE

  typeEquipement=$(mysql -u sio -p'btsinfo' -D MyGest -se "SELECT libelle FROM TypeE WHERE id=$idTypeE;")
  if [ -z "$typeEquipement" ]; then
    echo "Le Type d'équipement n'a pas été trouvé."
    exit 1
  fi

  echo "Type actuel : $typeEquipement"
  read -p "Entrez le nouveau nom du type : " newLibelle
  mysql -u sio -p'btsinfo' -D MyGest -e "UPDATE TypeE SET libelle='$newLibelle' WHERE id=$idTypeE;"
  echo "Le Type à été modifié."

  mysql -u sio -p'btsinfo' -D MyGest -e "SELECT * FROM TypeE;"

  ;;
0 )
  echo "Parfait."
  ;;
*)
  echo "Option non disponible."
  ;;
esac

echo "Retour au menu"
