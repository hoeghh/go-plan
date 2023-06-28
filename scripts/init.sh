#!/bin/bash
if [ -f "bura.yaml" ]; then
    VARS=$(cat bura.yaml | yq e '.vars | .. | select(. == "*") | {(path | . as $x | (.[] | select((. | tag) == "!!int") |= (["[", ., "]"] | join(""))) | $x | join("_") | sub(".\[", "[")): .} ' -  | sed "s/: /=/g")
    echo "- Exporting vars"
    while IFS= read -r line; do
        eval "export $line"
        echo "export $line"
    done <<< "$VARS"
else
  echo "bura.yaml not found"
  exit 1
fi