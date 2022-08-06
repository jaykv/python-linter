#!/bin/bash

set -e
shopt -s globstar

# source = $1
# strict = $2
# mypy-options = $3
# pylint-options = $4
# black-options = $5
# isort-options = $6

echo "===== Running Python Linter - '$2' ====="

if [ "$3" != false ]; then
  echo "Running mypy"
  mypy "$1" --show-error-codes --show-error-context --pretty ${3}
fi

echo "Running black"
if [ "$2" = "high" ]; then
  black "$1" ${5} --check
  echo "Running isort"
  isort "$1"/**/*.py -m 3 --trailing-comma ${6} -c
  echo "Running pylint"
  pylint "$1" ${4}

elif [ "$2" = "medium" ]; then
  black "$1" ${5} --check
  echo "Running isort"
  isort "$1"/**/*.py -m 3 --trailing-comma ${6} -c
  echo "Running pylint"
  pylint "$1" --fail-under=8 ${4}

else
  black "$1" ${5} --check
  echo "Running isort"
  isort "$1"/**/*.py -m 3 --trailing-comma ${6} --diff
  echo "Running pylint"
  pylint "$1" --exit-zero ${4}
fi


echo "Done 🎉" ; echo ""