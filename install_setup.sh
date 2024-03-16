#!/bin/bash

# Check for root privileges (often needed to modify /usr/local/bin)
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run with root privileges (e.g., sudo ./install_setup.sh)" 
   exit 1
fi

# Destination for the setup script
SETUP_SCRIPT_DESTINATION="/usr/local/bin/setup_typescript"

# Copy the setup_typescript script (replace with the actual path)
cp ./setup_typescript.sh $SETUP_SCRIPT_DESTINATION

# Make it executable 
chmod +x $SETUP_SCRIPT_DESTINATION

echo "Installation successful!"
echo "You can now create a new TypeScript Express project by running: setup_typescript"

