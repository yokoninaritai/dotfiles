export ZSH=$HOME/.oh-my-zsh
#ZSH_THEME="frisk"
#ZSH_THEME="simple"
ZSH_THEME="gentoo"
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration
unsetopt correct_all
#=============================
# PATH
#=============================
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin

#=============================$
# source ruby
#=============================$
if [ -d ~/.rbenv ]; then
    export PATH=$PATH:$HOME/.rbenv/bin
    eval "$(rbenv init -)"
fi

#=============================
# source perl
#=============================
export PATH=$HOME/.plenv/bin:$PATH
eval "$(plenv init -)"

#=============================
# source node
#=============================
export PATH=$HOME/.nodenv/bin:$PATH
eval "$(nodenv init -)"

#=============================
# source golang
#=============================
#source ~/.gvm/scripts/gvm

#=============================
# source python
#=============================
#export PYENV_ROOT=/usr/local/var/pyenv
#if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

#=============================
# Alias
#=============================
case "${OSTYPE}" in
    freebsd*|darwin*)
        alias ls='ls -hal -G -w'
        alias ctags='/Applications/MacVim.app/Contents/MacOS/ctags "$@"'
        alias lg="find . -type d -name .svn -prune -o -type f -print | xargs lgrep -n"
            ;;
    linux*)
        alias ls="ls --color"
        ;;
    solaris*)
        alias ls='gls -F --color=auto '
esac
alias irb='irb --simple-prompt'
# ls
alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"
alias lla="ls -al"

# process
alias 'ps?'='pgrep -l -f'

# du/df
alias du="du -h"
alias df="df -h"
alias duh="du -h ./ --max-depth=1"

# su
alias su="su -l"

# vim
alias v='vim'
alias 'src'='exec zsh'
alias -g V="| vim -"

# rails
alias -g RET="RAILS_ENV=test"
alias -g RED="RAILS_ENV=development"
alias -g REP="RAILS_ENV=production"

# rake
alias raket='RAILS_ENV=test rake'
alias raked='RAILS_ENV=development rake'
alias rakep='RAILS_ENV=production rake'

# less
alias less='less -r'

# grep
alias 'gr'='grep --color=auto -ERUIn'

# git

# other
alias diff='colordiff'
alias less='less -R'

#=============================
# history
#=============================
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups # ignore duplication command history list
setopt share_history # share command history data
setopt extended_history
function history-all { history -E 1 }

#=============================
# Search History
#=============================
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

#=============================
# setopt
#=============================
autoload -U compinit #補完機能
compinit -u

#autoload -U predict-on # 先方予測機能
#predict-on

setopt auto_cd
setopt auto_pushd

# --prefix=~/localというように「=」の後でも
#「~」や「=コマンド」などのファイル名展開を行う。
setopt magic_equal_subst

setopt correct # コマンド自動修正
setopt list_packed # 補完候補を詰めて表示
setopt nolistbeep # 補完表示時にビープ音を鳴らさない
setopt complete_aliases # エイリアスを設定したコマンドでも補完機能を使えるようにする
setopt transient_rprompt # コピペしやすいようにコマンド実行後は右プロンプトを消す。
setopt long_list_jobs # 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt list_types # 補完候補一覧でファイルの種別をマーク表示
setopt complete_in_word # カーソル位置で補完する。
setopt glob_complete # globを展開しないで候補の一覧から補完する。
setopt hist_expand # 補完時にヒストリを自動的に展開する。
setopt no_beep # 補完候補がないときなどにビープ音を鳴らさない。
setopt numeric_glob_sort # 辞書順ではなく数字順に並べる。
setopt rm_star_wait # rm * を実行する前に確認
setopt hist_no_store # history コマンドを history に保存しない
setopt mark_dirs # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt no_flow_control # disable C-q, C-s
setopt auto_param_slash # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt brace_ccl # {a-c} を a b c に展開する機能を使えるようにする

#=============================
# zstyle
#=============================

# 補完のグループ化
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=2 # 補完メニューの表示
zstyle ':completion:*:default' list-colors "" # 補完候補の色分け
zstyle ':completion:*' use-cache true # 補完候補をキャッシュする。
zstyle ':completion:*' verbose yes # 詳細な情報を使う。
zstyle ':completion:sudo:*' environ PATH="$SUDO_PATH:$PATH" # sudo時にはsudo用のパスも使う。
zstyle ':vcs_info:*' enable git # svn hg bzr # git以外ではvcs_infoを利用しない

# set terminal title including current directory
#
case "${TERM}" in
    kterm*|xterm)
        precmd() {
            echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
        }
        ;;
esac

#autojump
alias j="autojump"
if [ -f `brew --prefix`/etc/autojump ]; then
  . `brew --prefix`/etc/autojump
fi

#表示されているコマンドラインを
#Ctrl-x Ctrl-pでクリップボードにコピー
pbcopy-buffer(){
    echo $BUFFER | pbcopy
    zle -M "pbcopy: ${BUFFER}"
}

zle -N pbcopy-buffer
bindkey '^x^p' pbcopy-buffer

unset LD_LIBRARY_PATH
unset DYLD_LIBRARY_PATH

# The next line updates PATH for the Google Cloud SDK.
#source '/Users/matsuken/google-cloud-sdk/path.zsh.inc'

# The next line enables shell command completion for gcloud.
#source '/Users/matsuken/google-cloud-sdk/completion.zsh.inc'

# docker
#export DOCKER_CERT_PATH=/Users/matsuken/.boot2docker/certs/boot2docker-vm
#export DOCKER_TLS_VERIFY=1
#export DOCKER_HOST=tcp://192.168.59.103:2376

# golang
if [ -d "$HOME/.goenv" ]; then
  export GOENV_ROOT="$HOME/.goenv"
  export PATH="$GOENV_ROOT/bin:$PATH"
  export GOPATH="$HOME/go"
  export PATH="$GOPATH/bin:$PATH"
  which goenv > /dev/null && eval "$(goenv init -)"
fi

#eval "$(direnv hook zsh)"

#if [ -d "$HOME/.cargo" ]; then
#  export PATH="$HOME/.cargo/bin:$PATH"
#fi

## cdr
autoload -Uz add-zsh-hock
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook

## antigen
if [[ -f $HOME/.zsh/antigen/antigen.zsh ]]; then
  source $HOME/.zsh/antigen/antigen.zsh
  antigen bundle mollifier/anyframe # 追加
  antigen apply
fi

function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history


export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

#export GOOGLE_APPLICATION_CREDENTIALS=~/sharefull-github/sharefull-devops/terraform/sharefull/backend_key.json
#export GOOGLE_APPLICATION_CREDENTIALS=~/sharefull-login-prod-firebase.json

export PATH="/usr/local/opt/mysql-client/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/mysql-client/lib"
export CPPFLAGS="-I/usr/local/opt/mysql-client/include"
export PATH=/usr/local/opt/openssl/bin:$PATH

export PATH="/usr/local/bin:$PATH"
#export PATH="/usr/local/opt/gettext/bin:$PATH"
#export LDFLAGS="-L/usr/local/opt/gettext/lib"
#export CPPFLAGS="-I/usr/local/opt/gettext/include"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/matsuken/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/matsuken/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/matsuken/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/matsuken/google-cloud-sdk/completion.zsh.inc'; fi
