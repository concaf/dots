if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi


export GOPATH=~/go_play

export PATH=$PATH:$GOPATH/bin
export GOBIN=~/go_play/bin
export CDPATH=.$GOPATH/src/github.com
source <(~/opencompose/bin/opencompose completion bash)
source <(~/kompose/bin/kompose completion bash)

. /usr/share/git-core/contrib/completion/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1

PROMPT_COMMAND=__prompt_command

__prompt_command() {
    local EXIT="$?"
    PS1=""

   ##-ANSI-COLOR-CODES-##

   No_Color="\[\033[0m\]"

   ###-Regular-###
   Red="\[\033[0;31m\]"
   Green="\[\033[0;32m\]"
   Blue="\[\033[0;34m\]"
   Purple="\[\033[0;35m\]"
   Yellow="\[\033[0;33m\]"

   ####-Bold-####
   BRed="\[\033[1;31m\]"
   BGreen="\[\033[1;32m\]"
   BBlue="\[\033[1;34m\]"
   BPurple="\[\033[1;35m\]"

		if [ $EXIT != 0 ]; then
        PS1+="${Red}💢"
    else
        PS1+="${Green}💢"
    fi

    PS1+="${Blue}\u${No_Color} ${Purple}\W${Yellow}$(__git_ps1 " (%s)") ${BRed}$ ${No_Color}"
}
