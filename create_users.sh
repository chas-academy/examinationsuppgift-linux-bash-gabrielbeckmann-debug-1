#!/bin/bash 
#Här börjar shebang för följande skript

#Här börjar kontrollen för om användaren är root
if test $UID -ne 0; then
  echo "Användare måste vara root"
  exit 1 
fi

#Här görs en kontroll för att se att scriptet tar emot argument
if test $# -eq 0; then
  echo "Det finns inga argument"
  exit 1
fi

#Här börjar själva for loopen med lista som lagrar användare som läggs in som argument. Listan skapar ett home directory för varje användare och skapar sedan nödvändiga mappar. Därefter ändras ägarskapet av mappen till användaren och rwx rättigheter sätts efteråt.
for user in "$@"; do
  useradd -m $user
  mkdir /home/$user/documents
  mkdir /home/$user/downloads
  mkdir /home/$user/work
  chown $user /home/$user/documents
  chown $user /home/$user/downloads
  chown $user /home/$user/work
  chmod 700 /home/$user/documents
  chmod 700 /home/$user/downloads
  chmod 700 /home/$user/work
  echo "Välkommen" $user > /home/$user/welcome.txt
  echo "Här är en lista på alla andra användare i systemet" >> /home/$user/welcome.txt
  compgen -u | grep -v "$user" >> /home/$user/welcome.txt
done
