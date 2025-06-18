#!/bin/bash
REPO=${1:-https://github.com/PartOfDark/shvirtd-example-python.git}
DRY_RUN=false
TOOLS="git" "docker"

if [ -z "$1" ]; then
  echo "first arg is empty, running default project $REPO"
fi

if [ "$2" == "--dry-run" ]; then
  echo "dry run enabled, repo will be not install"
  DRY_RUN=true
fi

for tool in "${TOOLS[@]}"; do
  echo "checking $tool"
  if ! command -v "$tool" &>/dev/null; then
    echo "$tool is not installed"
    exit 1
  fi
done

if ! docker compose version &>/dev/null; then
  echo "docker compose plugin is missing or broken"
  exit 1
fi

if [ "$DRY_RUN" == false ]; then
  mkdir -p /opt || { echo "failed to create /opt"; exit 1; }
  rm -rf /opt/project
  echo "cloning repo"
  git clone "$REPO" /opt/project || { echo "clone failed"; exit 1;}
  cd /opt/project || { echo "failed to enter /opt/project"; exit 1; }
  echo "launching project with compose..."
  docker compose up -d
else
  echo "dry run skipping cloning repo"
  echo "dry run skipping launching project with compose..."
fi
  

