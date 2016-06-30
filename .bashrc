# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi


# Put your fun stuff here.

################################################################################
# Default keyboard map
################################################################################
#setxkbmap us

################################################################################
# Aliases general
################################################################################
alias emacs='emacs -nw'
alias ll='ls -l'
alias ack='ack --ignore-dir=x86'
alias eclipse='nohup /home/akhorsandi/eclipse_mars/eclipse/eclipse &'
alias build_cusfp3='./rpmbuild.pl -init -rev r27a cu4appl && ./rpmbuild.pl cu4appl'

################################################################################
# Aliases GIT
################################################################################
alias cdg='cd /usr/local/src/git'
alias gits='git status'
alias gd='git diff'
alias gbv='git branch -vv'
alias gu='git fetch && git merge FETCH_HEAD'
alias gl='git log'
alias gri='git rebase -i origin/master'
alias gr='git rebase origin/master'
alias gddlb='git branch -vv | grep gone] | cut -d' ' -f3 | xargs git branch -D'

################################################################################
# Git friendly prompt
################################################################################
export PROMPT_DIRTRIM=3
PS1='\[\e[0;32m\]\u@\h\[\e[m\] \[\e[00;33m\]\w\[\e[m\] \[\e[0;32m\]> \[\e[0m\]'
export PROMPT_DIRTRIM=2

_git_basic_ps1() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/^* //'
}

_GITPS_BEGIN="\[\033[00;33m\]"
_GITPS_END="\[\033[0;34m\]|\[\033[0m\]"

if [ "$(type -t __git_ps1)" ]; then
    PS1="$_GITPS_BEGIN\$(__git_ps1 '%s')$_GITPS_END$PS1"
elif which git &> /dev/null; then
    PS1="$_GITPS_BEGIN\$(_git_basic_ps1)$_GITPS_END$PS1"
fi

export PS1
export EDITOR
################################################################################
# PATH modifications for coverity
################################################################################
PATH=$PATH:/files/apps/tm3000_jenkins/coverity/cov-analysis/latest/bin/

################################################################################
# Shell functions
################################################################################
function emacsf() {
   emacs -nw $(find . -name "$1")
}

function gitc() {
   git checkout "$1"
}

function work_load() {
   git log | grep "$1" | wc -l
}
