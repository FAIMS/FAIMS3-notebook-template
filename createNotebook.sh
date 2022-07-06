#!/bin/bash

set -euo pipefail

export SERVER_FULLNAME="${1:-dev.db.faims.edu.au}" # dev, alpha, testing, selenium
cp csirogeochem.json faims3-temp-notebook-migrator/
cd faims3-temp-notebook-migrator
echo "Load Geochem ${SERVER_FULLNAME}"
#sed -e "s/##SPID##/${SPID}/g" 20220110-model1.json > fiptemp.json
bash loadNotebook.sh $SERVER_FULLNAME "CSIRO Geochem $(date)" "csirogeochem.json" "csirogeochem"
rm -f faims3-temp-notebook-migrator/csirogeochem.json
rm -f faims3-temp-notebook-migrator/testnotebook.json