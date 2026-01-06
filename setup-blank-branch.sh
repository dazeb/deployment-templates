#!/bin/bash

# Setup script for creating blank template branch

echo "Setting up blank template branch..."

# Make sure we're in the deployment-templates directory
cd "$(dirname "$0")"

# Check if we're in a git repo
if [ ! -d .git ]; then
  echo "Initializing git repository..."
  git init
  git add .
  git commit -m "Initial commit: Template structure"
  git branch -M main
  git remote add origin https://github.com/dazeb/deployment-templates.git
  git push -u origin main
fi

# Create blank branch
echo "Creating blank branch..."
git checkout -b blank

# Move blank template files to root
echo "Moving blank template to root..."
cp blank/docker-compose.yml .
cp blank/.env.example .
cp blank/README.md ./TEMPLATE-README.md

# Remove folder structure (keep only files at root)
echo "Cleaning up folder structure..."
rm -rf blank/
rm -rf blog/
rm -rf ecommerce/
rm README.md  # Remove main README (not needed in template branch)

# Commit blank template
echo "Committing blank template..."
git add .
git commit -m "Blank Payload CMS template - docker-compose at root"

# Push to GitHub
echo "Pushing to GitHub..."
git push -u origin blank

# Return to main branch
echo "Returning to main branch..."
git checkout main

echo ""
echo "✅ Blank template branch created successfully!"
echo ""
echo "Branches:"
git branch -a
echo ""
echo "Next steps:"
echo "1. Verify branch on GitHub: https://github.com/dazeb/deployment-templates/tree/blank"
echo "2. Test deployment via PayloadServers backend"
