#!/bin/bash

COMMIT_ID=$1

cd data
# Check for .git directory
if [[ ! -d ".git" ]]; then echo "This project does not have a git directory" && exit 1; fi

# Check for presence of COMMIT_ID
if [[ -z "$COMMIT_ID" ]]; then echo "Commit id was not provided to script. Attempting to use most recent commit id instead" && \
  COMMIT_ID=$(git log --format="%H" -n 1) && echo -e "${COMMIT_ID}\n"; fi

# Check for presence of commit id on branch
COMMIT_CHECK=$(git branch --contains ${COMMIT_ID} 2> /dev/null)
if [[ ! $COMMIT_CHECK ]]; then echo "Commit ID: ${COMMIT_ID} is not detected in this repository." && exit 1; fi

REPO_NAME=$(basename -s .git `git config --get remote.origin.url`)
FILE_COLLECTION_DIR="/${REPO_NAME}-${COMMIT_ID}"
mkdir -p ${FILE_COLLECTION_DIR}
cp /meta.json ${FILE_COLLECTION_DIR}

git show ${COMMIT_ID}:codeship-steps.yml > ${FILE_COLLECTION_DIR}/codeship-steps.yml
git show ${COMMIT_ID}:codeship-services.yml > ${FILE_COLLECTION_DIR}/codeship-services.yml
zip "/data/codeship-configs-${REPO_NAME}-${COMMIT_ID}.zip" ${FILE_COLLECTION_DIR}/*

cd -
