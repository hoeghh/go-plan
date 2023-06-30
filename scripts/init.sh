#!/bin/bash
if [ -f "bura.yaml" ]; then
    ENVS=$(yq '. *n load(".plan/plan.yaml") | .vars' bura.yaml)
    VARS=$(echo -e "$ENVS" | yq e '. | .. | select(. == "*") | {(path | . as $x | (.[] | select((. | tag) == "!!int") |= (["[", ., "]"] | join(""))) | $x | join("_") | sub(".\[", "[")): .} ' - | sed "s/: /=/g")
    echo "- Exporting vars"
    while IFS= read -r line; do
        eval "export $line"
    done <<< "$VARS"
else
  echo "bura.yaml not found"
  exit 1
fi