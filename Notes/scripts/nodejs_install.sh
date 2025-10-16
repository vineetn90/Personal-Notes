#!/usr/bin/env bash
# installs nvm (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash &&
#close terminal 
osascript -e 'tell application "Terminal" to close first window' &> /dev/null
#open terminal 
osascript -e 'tell application "Terminal" to do script ""'
# download and install Node.js (you may need to restart the terminal)
nvm install 22 &&
# verifies the right Node.js version is in the environment
node -v &&
# should print `v22.12.0`
# verifies the right npm version is in the environment
npm -v # should print `10.9.0`