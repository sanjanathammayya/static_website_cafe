#!/bin/bash
sudo apt-get update -y
sudo apt-get install apache2 -y
# Destination directory
sudo git clone https://github.com/neehar2601/static-website.git
sudo mkdir /var/www/html/staticweb
sudo cp -rf static-website/* /var/www/html/staticweb/.
DEST_DIR="/var/www/html/staticweb"

# Check if the destination directory exists
if [ ! -d "$DEST_DIR" ]; then
    # If the directory doesn't exist, create it
    sudo mkdir -p "$DEST_DIR"

    # Copy files only if the destination directory was created
    if [ $? -eq 0 ]; then
        sudo cp -rf * "$DEST_DIR/"
        echo "Files copied to $DEST_DIR."
    else
        echo "Failed to create directory $DEST_DIR."
    fi
else
    echo "Directory $DEST_DIR already exists. Skipping copy."
fi
#echo "DocumentRoot /var/www/html/bookalbum" | sudo tee -a  /etc/apache2/sites-available/000-default.conf
#sudo sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/bookalbum|' /etc/apache2/sites-available/000-default.conf
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/staticweb.conf
sudo sed -E -i 's|DocumentRoot[[:space:]]+/var/www/html/[^[:space:]]*|DocumentRoot /var/www/html/staticweb|' /etc/apache2/sites-available/staticweb.conf
sudo a2ensite staticweb.conf
sudo systemctl reload apache2

sudo systemctl restart apache2
