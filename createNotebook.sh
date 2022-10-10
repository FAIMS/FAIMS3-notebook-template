#!/bin/bash

set -euo pipefail

gitdir=$(basename "$(git rev-parse --show-toplevel)")
jsonfile=$(find . -name "*.json" -a ! -name "secret*json" | head -n1 )
projectname=$(echo -n "$gitdir" | sed -r 's#./FAIMS3-[^-]+-##g' | sed 's/_/ /g' | sed -r 's/^[_ ]//')
export PROJECT_KEY=$(echo "${projectname,,}" | sed -E "s/[^A-Za-z0-9]+/_/g" | sed -E "s/_+$//")
export SERVER_FULLNAME="testing.db.faims.edu.au" # dev, alpha, testing, selenium

echo "Using $gitdir with $jsonfile as $projectname ($PROJECT_KEY) onto $SERVER_FULLNAME. (Currently head -n1)"



cp "$jsonfile" faims3-temp-notebook-migrator/
cd faims3-temp-notebook-migrator		
#sed -e "s/##SPID##/${SPID}/g" 20220110-model1.json > fiptemp.json
bash loadNotebook.sh $SERVER_FULLNAME "$projectname" "$jsonfile" "$PROJECT_KEY" || true
rm "$jsonfile"
echo "Done with $jsonfile"
