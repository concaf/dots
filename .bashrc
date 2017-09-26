if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi


export GOPATH=~/go_play

export PATH=$PATH:$GOPATH/bin
export GOBIN=~/go_play/bin
export CDPATH=.$GOPATH/src/github.com
source <(~/opencompose/bin/opencompose completion bash)
source <(~/kompose/bin/kompose completion bash)
source <(~/kedge/bin/kedge completion bash)
#source <(minikube completion bash)

. /usr/share/git-core/contrib/completion/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1

PROMPT_COMMAND=__prompt_command

__prompt_command() {
    local EXIT="$?"
    eval "$(direnv hook bash)"
    PS1=""

   ##-ANSI-COLOR-CODES-##

   No_Color="\[\033[0m\]"

   ###-Regular-###
   Red="\[\033[0;31m\]"
   Green="\[\033[0;32m\]"
   Blue="\[\033[0;94m\]"
   Purple="\[\033[0;95m\]"
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

# 	oc project -q &> /dev/null
# 	if [ $? -eq 0 ]; then
# 	  OC_PSI=" ${BRed}$(oc whoami)${Red}@${BRed}$(oc project -q)${No_Color} "
#   fi
#      PS1+="${Blue}\u${No_Color} ${Purple}\W${Yellow}$(__git_ps1 " (%s)")$OC_PSI$ ${No_Color}"
    PS1+="${Blue}\u${No_Color} ${Purple}\W${Yellow}$(__git_ps1 " (%s)") $ ${No_Color}"
}

kube_switch_namespace() {
  kubectl get namespace $1 &> /dev/null
  if [ $? -eq 0 ]; then
    echo "Switching to namespace: $1"
    kubectl config set-context $(kubectl config current-context) --namespace=$1 > /dev/null
  else
    echo "Namespace: $1 does not exist"
    kill -INT $$ 
  fi
}

review_pull_request() {
	# review_pull_request <pull request ID> <local branch name> <remote name>
  if [ "$#" -eq 1 ]; then
    echo "Setting local branch to $1"
    local_branch=$1
    echo "Setting remote to 'upstream'"
    remote_name="upstream"
    echo "Fetching pull request $1"
    pull_id=$1
  elif [ "$#" -eq 2 ]; then
    echo "Setting local branch to $2"
    local_branch=$2
    echo "Setting remote to 'upstream'"
    remote_name="upstream"
    echo "Fetching pull request $1"
    pull_id=$1
  elif [ "$#" -eq 3 ]; then
    echo "Setting local branch to $2"
    local_branch=$2
    echo "Setting remote to $3"
    remote_name=$3
    echo "Fetching pull request $1"
    pull_id=$1
  else
    echo "Invalid syntax: use review_pull_request <pull request ID> <local branch name, optional> <remote name, optional>"
    kill -INT $$
  fi
  echo "Running: git fetch $remote_name pull/$pull_id/head:$local_branch -f"
  git fetch $remote_name pull/$pull_id/head:$local_branch -f
}

export ANSIBLE_NOCOWS=1

# added by travis gem
[ -f /home/concaf/.travis/travis.sh ] && source /home/concaf/.travis/travis.sh
export PATH=$PATH:~/.fabric8/bin
export PATH=/home/concaf/kubernetes/src/k8s.io/kubernetes/third_party/etcd:${PATH}
alias ck=/home/concaf/kubernetes/src/k8s.io/kubernetes/cluster/kubectl.sh
