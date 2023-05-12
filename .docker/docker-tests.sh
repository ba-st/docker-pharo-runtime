#!/usr/bin/env bash

readonly ANSI_BOLD="\\033[1m"
readonly ANSI_GREEN="\\033[32m"
readonly ANSI_BLUE="\\033[34m"
readonly ANSI_RESET="\\033[0m"

# Do not output colors if not running under a TTY (eg, piped or a non interactive shell)

print_info() {
  if [ -t 1 ]; then
    printf "${ANSI_BOLD}${ANSI_BLUE}%s${ANSI_RESET}\\n" "$1"
  else
    echo "$1"
  fi
}

print_success() {
  if [ -t 1 ]; then
    printf "${ANSI_BOLD}${ANSI_GREEN}%s${ANSI_RESET}\\n" "$1"
  else
    echo "$1"
  fi
}

run_in_compose() {
  export COMPOSE_FILE=$1
  docker compose up --abort-on-container-exit
  docker compose down || docker compose kill
  unset "$COMPOSE_FILE"
}

run_in_compose_and_test_with_curl() {
  export COMPOSE_FILE=$1
  local SLEEP=${2:-1} # Default to 1 second
  docker compose up --detach
  sleep "$SLEEP"
  curl -f http://localhost
  print_success "OK"
  docker compose down || docker compose kill
  unset "$COMPOSE_FILE"
}

set -e

print_info "Pulling dependencies"
docker pull traefik:v2.10

print_info "Building base image"
docker build --tag pharo-runtime:sut ../source

print_info "Building loader base image"
docker build \
  --build-arg BASE_IMAGE=pharo-runtime \
  --build-arg VERSION=sut \
  --tag pharo-loader:sut \
  --file ../source/Dockerfile-loader \
  ../source

print_info "Test #1 - Evaluating code"
run_in_compose docker-compose-eval.yml
print_success "Test #1 - Evaluating code ...[OK]"

print_info "Test #2 - Accessing version"
run_in_compose docker-compose-version.yml
print_success "Test #2 - Accessing version ...[OK]"

print_info "Test #3 - Loading code"
run_in_compose docker-compose-loading-code.yml
print_success "Test #3 - Loading code ...[OK]"

print_info "Building pharo-date image"
docker build --tag pharo-date:sut pharo-date-multistage

print_info "Test #4 - Current date"
run_in_compose_and_test_with_curl docker-compose-pharo-date.yml
print_success "Test #4 - Current date ...[OK]"

print_info "Test #5 - Current date multistage"
run_in_compose_and_test_with_curl docker-compose-pharo-date-multistage.yml
print_success "Test #5 - Current date multistage...[OK]"

print_info "Test #6 - Current date balanced"
run_in_compose_and_test_with_curl docker-compose-balanced-pharo-date.yml 5
print_success "Test #6 - Current date balanced...[OK]"
