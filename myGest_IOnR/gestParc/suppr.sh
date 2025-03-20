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