#!/bin/bash
origin=''
branch=''
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'
while getopts "o:b:" opt; do
  case $opt in
    o) origin=$OPTARG ;;
    b) branch=$OPTARG ;;
    *) echo 'error' >&2
       exit 1
  esac
done

if [[ -z $origin ]]; then
  echo >&2 "Please supply an origin to push to."
  exit 1
fi

if [[ -z $branch ]]; then
  echo >&2 "Please supply a branch name to copy from."
  exit 1
fi

update_client() {
  cli_branch="cli-$branch"
  echo "${GREEN}Checking out orphan branch...${NC}"
  git checkout --orphan $cli_branch $branch
  echo "${GREEN}Commiting branch...${NC}"
  git commit -m "Sbx delivery $(date)"
  echo "${GREEN}Pushing to $origin $cli_branch ${NC}..."
  git push -f $origin $cli_branch
  echo "${GREEN}Moving off client branch...${NC}"
  git checkout $branch
  echo "${GREEN}Delete temp branch...${NC}"
  git branch -D $cli_branch
}

while true; do
    read -p "$(echo "Update ${RED}$origin${NC} with a client branch: ${YELLOW}cli-$branch${NC}? (y/n) ")" yn
    case $yn in
        [Yy]* ) update_client; echo 'Done'; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
