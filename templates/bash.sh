#!/usr/bin/env bash
#/ DESCRIPTION:
#/-
#/ This is a bash template for writing beautiful CLIs.
#/-
#/
#/ USAGE:-
#/   script-name --option VAL --name NAME [--optional-opt OPTVAL] [ARG...]
#/
#/ SYNOPSIS:
#/   -h|--help: Prints this message.
#/   -o|--option VAL: Sample option.
#/   --name NAME: Name option description.
#/   --optional-opt OPTVAL: Optional option description (default: myval).

set -euo pipefail

# ----------------
# ░█░█░█▀█░█▀▄░█▀▀
# ░▀▄▀░█▀█░█▀▄░▀▀█
# ░░▀░░▀░▀░▀░▀░▀▀▀
# ----------------

# NOTE: Colors
__STYLE_RESET='\e[0m'
__STYLE_BOLD='\e[1m'
__STYLE_CYAN='\e[36m'
__STYLE_BCYAN='\e[36;1m'
__STYLE_GREEN='\e[32m'
__STYLE_BGREEN='\e[32;1m'
__STYLE_RED='\e[31m'
__STYLE_BRED='\e[31;1m'
__STYLE_YELLOW='\e[33m'
__STYLE_BYELLOW='\e[33;1m'

# NOTE: CLI options
__OPTION_HELP="0"
__OPTION_MYOPT=""
__OPTION_COUNT=""

# NOTE: Evaluated constants
__SCRIPT_DIR="$(cd "$(dirname "$(realpath "${0}")")" && pwd)"

# --------------------
# ░█░█░▀█▀░▀█▀░█░░░█▀▀
# ░█░█░░█░░░█░░█░░░▀▀█
# ░▀▀▀░░▀░░▀▀▀░▀▀▀░▀▀▀
# --------------------

# NOTE: Print error message and exit
__errexit() {
  __log error "${1:-Unexpected error}"
  exit 1
}

# NOTE: Logging utility function
__log() {
  local _level="${1:-info}"
  _level="${_level^^}"
  local _msg="${2:-}"

  local _level_color="${__STYLE_BOLD}"
  local _msg_color=""
  case "${_level}" in
  INFO)
    _level_color="${__STYLE_BCYAN}"
    _msg_color="${__STYLE_CYAN}"
    ;;
  SUCCESS)
    _level_color="${__STYLE_BGREEN}"
    _msg_color="${__STYLE_GREEN}"
    ;;
  WARN | WARNING)
    _level_color="${__STYLE_BYELLOW}"
    _msg_color="${__STYLE_YELLOW}"
    ;;
  ERROR)
    _level_color="${__STYLE_BRED}"
    _msg_color="${__STYLE_RED}"
    ;;
  esac

  printf "${_level_color}%s, %s:${__STYLE_RESET}${_msg_color} %s${__STYLE_RESET}\n" "$(date '+%F %H:%M:%S')" "${_level}" "${_msg}" >&2
}

# ----------------------------
# ░█▀█░█▀█░█▀▄░█▀▀░▀█▀░█▀█░█▀▀
# ░█▀▀░█▀█░█▀▄░▀▀█░░█░░█░█░█░█
# ░▀░░░▀░▀░▀░▀░▀▀▀░▀▀▀░▀░▀░▀▀▀
# ----------------------------

__parse_args() {
  while (("${#}")); do
    local __arg="${1:-}"
    local __value="${2:-}"

    case "${__arg}" in
    -h | --help)
      __OPTION_HELP=1
      ;;
    -o | --option)
      __OPTION_MYOPT="${__value}"
      shift
      ;;
    *)
      __errexit "Unexpected option: ${__arg}"
      ;;
    esac

    shift
  done
}

__check_dependencies() {
  # NOTE: Check required commmands
  for cmd in ssh scp; do
    if ! command -v "${cmd}" &>/dev/null; then
      __errexit "Command not found: ${cmd}"
    fi
  done

  # NOTE: Check required options
  if [ -z "${__OPTION_MYOPT}" ]; then __errexit "Missing option: --option"; fi

  # NOTE: Additional checks
  # ...
}

# --------------------------------------------
# ░█▀▀░█░█░█▀▄░█▀▀░█▀█░█▄█░█▄█░█▀█░█▀█░█▀▄░█▀▀
# ░▀▀█░█░█░█▀▄░█░░░█░█░█░█░█░█░█▀█░█░█░█░█░▀▀█
# ░▀▀▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░▀░▀░▀░▀░▀░▀░▀░▀░▀▀░░▀▀▀
# --------------------------------------------

_help() {
  grep '^#/' <"${0}" | cut -c 4-
}

_main() {
  if [ "${__OPTION_HELP}" = "1" ]; then
    _help
    exit 0
  fi

  __check_dependencies
  trap '__log error "Received termination signal, exiting"' TERM ERR
}

__parse_args "${@}"
_main
