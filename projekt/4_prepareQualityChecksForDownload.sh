#!/bin/bash

# przygotowanie plików html z raportami jakości do pobrania z serwera celem oceny wizualnej
zip qualityCheck.zip ./qualityChecks/*.html
mv ./qualityChecks/qualityCheck.zip ~/

echo 'Komenda do pobrania raportów'
echo 'scp s119494@lupin.upwr.edu.pl:~/qualityCheck.zip ./qualityCheck.zip'
