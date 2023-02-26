#!/bin/bash
this="$(dirname "$(realpath "$BASH_SOURCE")")"

# https://github.com/git/git/blob/dadc8e6dacb629f46aee39bde90b6f09b73722eb/contrib/completion/git-prompt.sh
. $this/vendor/git-prompt.sh

__my_git_ps1 () {
	GIT_PS1_SHOWDIRTYSTATE=1 \
	GIT_PS1_SHOWUNTRACKEDFILES=1 \
	GIT_PS1_SHOWUPSTREAM="verbose,name" \
	GIT_PS1_SHOWCONFLICTSTATE=1 \
	GIT_PS1_SHOWCOLORHINTS=1 \
	__git_ps1 " [%s]"
}
