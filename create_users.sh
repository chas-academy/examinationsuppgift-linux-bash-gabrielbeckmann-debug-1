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
  mkdir /home/$user/Documents
  mkdir /home/$user/Downloads
  mkdir /home/$user/Work
  chown $user /home/$user/Documents
  chown $user /home/$user/Downloads
  chown $user /home/$user/Work
  chmod 700 /home/$user/Documents
  chmod 700 /home/$user/Downloads
  chmod 700 /home/$user/Work
  echo "Välkommen" $user > /home/$user/welcome.txt
  echo "Här är en lista på alla andra användare i systemet" >> /home/$user/welcome.txt
  compgen -u | grep -v "$user" >> /home/$user/welcome.txt
done
