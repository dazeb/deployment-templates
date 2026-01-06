# PowerShell script for creating blank template branch

Write-Host "Setting up blank template branch..." -ForegroundColor Cyan

# Make sure we're in the deployment-templates directory
Set-Location $PSScriptRoot

# Check if we're in a git repo
if (-not (Test-Path .git)) {
  Write-Host "Initializing git repository..." -ForegroundColor Yellow
  git init
  git add .
  git commit -m "Initial commit: Template structure"
  git branch -M main
  git remote add origin https://github.com/dazeb/deployment-templates.git
  git push -u origin main
}

# Create blank branch
Write-Host "Creating blank branch..." -ForegroundColor Yellow
git checkout -b blank

# Move blank template files to root
Write-Host "Moving blank template to root..." -ForegroundColor Yellow
Copy-Item blank/docker-compose.yml .
Copy-Item blank/.env.example .
Copy-Item blank/README.md ./TEMPLATE-README.md

# Remove folder structure (keep only files at root)
Write-Host "Cleaning up folder structure..." -ForegroundColor Yellow
Remove-Item -Recurse -Force blank/
if (Test-Path blog/) { Remove-Item -Recurse -Force blog/ }
if (Test-Path ecommerce/) { Remove-Item -Recurse -Force ecommerce/ }
Remove-Item README.md  # Remove main README (not needed in template branch)

# Commit blank template
Write-Host "Committing blank template..." -ForegroundColor Yellow
git add .
git commit -m "Blank Payload CMS template - docker-compose at root"

# Push to GitHub
Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
git push -u origin blank

# Return to main branch
Write-Host "Returning to main branch..." -ForegroundColor Yellow
git checkout main

Write-Host ""
Write-Host "✅ Blank template branch created successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Branches:" -ForegroundColor Cyan
git branch -a
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Verify branch on GitHub: https://github.com/dazeb/deployment-templates/tree/blank"
Write-Host "2. Test deployment via PayloadServers backend"
