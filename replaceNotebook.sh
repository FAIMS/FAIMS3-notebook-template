#!/bin/bash

set -euo pipefail



gitdir=$(basename "$(git rev-parse --show-toplevel)")
jsonfile=$(find . -name "*.json" -a ! -name "secret*json" | head -n1 )
projectname=$(echo -n "$gitdir" | sed -r 's#./FAIMS3-[^-]+-##g' | sed 's/_/ /g' | sed -r 's/^[_ ]//')
export PROJECT_KEY=$(echo "${projectname,,}" | sed -E "s/[^A-Za-z0-9]+/_/g" | sed -E "s/_+$//")
echo "Using $gitdir with $jsonfile as $projectname ($PROJECT_KEY) onto: $(jq .url secret.json)"

python3.10 faims3-temp-notebook-migrator/loadNotebook.py --project_key "$PROJECT_KEY" --notebook_json "$jsonfile"  --env-file=secret.json
