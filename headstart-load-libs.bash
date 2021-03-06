#!/usr/bin/env bash

# GO-SCRIPT
# =========
# From the docs:
# If you wish to use the framework to write a standalone program, rather than a
# project-specific development script, set _GO_STANDALONE in your top-level
# script to prevent alias commands, builtin commands, and plugin commands from
# showing up in help output or from being offered as tab completions. (help
# will still appear as a top-level tab completion.) All of these commands will
# still be available, but users won't be presented with them directly.
# _GO_STANDALONE also prevents the script from setting PWD to _GO_ROOTDIR,
# enabling the script to process relative file path arguments anywhere in the
# file system. Note that then you'll have to add _GO_ROOTDIR manually to any
# _GO_ROOTDIR-relative paths in your own scripts.
declare _GO_STANDALONE=true

# Initialize go-script-bash
. "$_HEADSTART_CORE_DIR/vendor/go-script-bash/go-core.bash" "$@"
# GO_SCRIPTS_DIR points to the **relative** directory where our custom commands
# are. It is the same with the (absolute path) HEADSTART_COMMANDS_DIR. We set it
# in the `headstart` entry script.  This allows us to set this variable to
# a custom value in our tests where we generate custom test scripts on the fly
# to test specific functionality (see
# lib/testing/environment:@go.create_test_go_script()).  There we set this
# variable to point somewhere under the project's tmp folder (see the
# `TEST_GO_SCRIPTS_RELATIVE_DIR` variable in the same file as above).

# BASH INFINITY
# =============
. "$_HEADSTART_CORE_DIR//vendor/bash-infinity/lib/oo-bootstrap.sh"
# <<-CODE_NOTE: bash-oo-framework sets `source` to an alias. Calls to
#               `source` in go-script-bash will use this alias.

# TODO Remove this when https://github.com/mbland/go-script-bash/issues/248
# gets resolved.
unalias "."
# <<-CODE_NOTE: Bash Infinity aliases both "source" and "." in order to
#               implement smart importing. The go-script uses "." to source
#               all its files. To avoid conflict and unneeded code execution,
#               here we unset the "." alias.

unalias 'source'
alias source=". \"\$_GO_USE_MODULES\""
# Aliasing it to `source` to allow shellcheck to source the files as well.

import UI/Color.var
import UI/Color
import util/log
import util/tryCatch
import util/variable
import util/namedParameters

# CUSTOM LIBS
# ===========
# TODO source directly due to variable scoping
. "$_HEADSTART_CORE_DIR/lib/headstart-sysexits"
. "$_GO_USE_MODULES" 'system'
. "$_GO_USE_MODULES" 'io'
# <<-CODE-NOTE: Loaded here in order to have its functions available in the
# test go scripts. There, the 'headstart' function in headstart-core is not used, so
# we need to explicitly call any function that is needed and that the 'headstart'
# function would have called if itself was run in the test go scripts.
