shopt -s globstar
shopt -s autocd
shopt -s cdspell
shopt -s histappend # merged history from multiple tabs instead of using the last one that gets closed
shopt -s direxpand # expands ~ on tab completing


# look in current directory (.), then home (~), then custom folders
export CDPATH=".:~:~/repos:~/repos/csp"

shopt -s extglob
shopt -s cmdhist

# Green color for user, Blue for path, Reset at end
 __git_branch() {
  git rev-parse --abbrev-ref HEAD 2>/dev/null
}

export PS1='\[\033[1;32m\]\u@\h \[\033[1;34m\]\w\[\033[0;33m\]$(__git_branch | sed "s/^/ (/;s/$/)/")\[\033[0m\] \$ '

# create dir and go into it
mkcd() {
    mkdir -p "$1"
    cd "$1"
}

# fast backup with timestamp
bu() {
    cp "$1" "$1_$(date +%F_%H-%M-%S).bak"
}

# find files by name under current dir
ff() { find . -type f -iname "*$1*" 2>/dev/null; }

# find directories by name under current dir
fd() { find . -type d -iname "*$1*" 2>/dev/null; }



# if you forget sudo, just type "please" or "fuck"
alias please='sudo $(history -p !!)'
alias fuck='sudo $(history -p !!)'


# who is using a port?
port() { sudo lsof -iTCP:"$1" -sTCP:LISTEN -n -P; }

# Kill by port
killport() { port "$1" | awk 'NR>1 {print $2}' | xargs -r sudo kill; }

# pretty-print JSON
jpp() { python3 -m json.tool < "$1"; }
