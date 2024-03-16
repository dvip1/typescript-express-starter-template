#!/bin/bash

# Get the project name with validation
while true; do
  read -p "Enter the desired project name (alphanumeric only): " PROJECT_NAME
  if [[ $PROJECT_NAME =~ ^[a-zA-Z0-9]+$ ]]; then
    break
  else
    echo "Error: Project name should only contain letters and numbers."
  fi
done

# Create the project directory and navigate to it
mkdir $PROJECT_NAME && cd $PROJECT_NAME

# Initialize npm
npm init -y

# Install dependencies with types
npm install express @types/express typescript ts-node

# Initialize TypeScript configuration with recommended settings
npx tsc --init --esModuleInterop true --target ES2022 --moduleResolution node

# Create src directory
mkdir src

# Create basic Express app in src/index.ts
cat << EOF > src/index.ts
import express from 'express';
const app = express();
const port = process.env.PORT || 3000; // Use environment variable for port 

app.get('/', (req, res) => {
  res.send('Hello from your TypeScript Express app!');
});

app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
EOF

# Add scripts to package.json with optional dev dependency
read -p "Install nodemon as a dev dependency? (y/n): " INSTALL_NODEMON
if [[ $INSTALL_NODEMON =~ ^([yY][eE][sS]|[yY])$ ]]; then
 npm install --save-dev nodemon
 npm install --save-dev @types/nodemon # Add types for nodemon
 jq '.scripts += { "dev": "nodemon src/index.ts" }' package.json > tmp.json && mv tmp.json package.json
else
 jq '.scripts += { "start": "node dist/index.js" }' package.json > tmp.json && mv tmp.json package.json
fi

