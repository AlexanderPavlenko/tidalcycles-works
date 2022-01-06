#!/bin/zsh -l
DIR=${${(%):-%x}:A:h} # https://stackoverflow.com/a/23259585
cd "$DIR" || exit 1

brew bundle

cabal v2-update
cabal v2-install tidal --lib

/Applications/Atom.app/Contents/Resources/app/apm/bin/apm install tidalcycles

curl -Lk https://github.com/supercollider/sc3-plugins/releases/download/Version-3.11.1/sc3-plugins-3.11.1-macOS-signed.zip --output /tmp/sc3plugins.zip
mkdir -p ~/Library/Application\ Support/SuperCollider/Extensions/
unzip -nq /tmp/sc3plugins.zip -d ~/Library/Application\ Support/SuperCollider/Extensions/
rm /tmp/sc3plugins.zip

echo 'include("SuperDirt");"SuperDirt installation complete!".postln;0.exit;' | /Applications/SuperCollider.app/Contents/MacOS/sclang