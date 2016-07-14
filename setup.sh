#!/usr/bin/env sh

# Run this script immediately after cloning the codebase.
# Removes Git remote + checks to see if you have node & grunt installed

# ============================================== #
# Functions
# ============================================== #

# return 1 if global command line program installed, else 0
# example
# echo "node: $(program_is_installed node)"
function program_is_installed {
  # set to 1 initially
  local return_=1
  # set to 0 if not found
  type $1 >/dev/null 2>&1 || { local return_=0; }
  # return value
  echo "$return_"
}

# return 1 if local npm package is installed at ./node_modules, else 0
# example
# echo "gruntacular : $(npm_package_is_installed gruntacular)"
function npm_package_is_installed {
  # set to 1 initially
  local return_=1
  # set to 0 if not found
  ls node_modules | grep -w $1 >/dev/null 2>&1 || { local return_=0; }
  # return value
  echo "$return_"
}

# display a message in red with a cross by it
# example
# echo echo_fail "No"
function echo_fail {
  # echo first argument in red
  printf "\e[31m✘ ${1}"
  # reset colours back to normal
  echo "\033[0m"
}

# display a message in green with a tick by it
# example
# echo echo_fail "Yes"
function echo_pass {
  # echo first argument in green
  printf "\e[32m✔ ${1}"
  # reset colours back to normal
  echo "\033[0m"
}

# echo pass or fail
# example
# echo echo_if 1 "Passed"
# echo echo_if 0 "Failed"
function echo_if {
  if [ $1 == 1 ]; then
    echo_pass $2
  else
    echo_fail $2
  fi
}


# ============================================== #
# Functions
# ============================================== #
echo "node          $(echo_if $(program_is_installed node))"
echo "grunt         $(echo_if $(program_is_installed grunt))"


# ============================================== #
# Remove Git remote if it's still the default repo
# ============================================== #
if [ "$(git config --get remote.origin.url)" = "https://github.com/mattrothenberg/labs-design-yeoman" ]; then
  echo "What is your repo url? Enter URL or leave blank"
  read url
  if [ -z "$url" ]; then
    git remote rm origin
    git remote add origin "$url"
  fi
fi