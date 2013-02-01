# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="miloshadzic"
DISABLE_AUTO_TITLE="true"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-flow github gpg-agent heroku lein pip python rails3 rake ruby rvm screen ssh-agent yum)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
alias po='msgfmt -cvo /dev/null pt_BR.po'
alias merge='msgmerge --update --previous pt_BR.po *.pot && po'
alias update='intltool-update --pot && intltool-update pt_BR'
alias liner='msgcat pt_BR.po -o pt_BR.po'
alias xfce='svn ci -m "Updated Brazilian Portuguese translation."'
alias gnomeci='git commit -a -m "Updated Brazilian Portuguese translation."'

alias checkpo='msgfmt -cvo /dev/null $1'
alias mergepo='msgmerge --update --previous $1 *.pot && po'
alias updatepo='intltool-update --pot && intltool-update pt_BR'
alias linerpo='msgcat $1 -o $1'

alias key='ssh-agent && ssh-add'
alias irc='ssh irc'
alias irc2='ssh irc2'
alias home='ssh home'

alias macme='sudo macchanger --mac=00:19:D2:44:27:E7 wlan0'
#alias updateall='sudo conary updateall --no-interactive'

alias cleanpyc='find . -iname "*.pyc" | xargs rm'
alias proj='xrandr --output VGA --mode 1024x768 --output LVDS --auto'
alias int='xrandr --output VGA --off --output LVDS --auto'
alias ext='xrandr --output VGA --auto --output LVDS --auto'

alias synergyslaptop='synergys -f --config ~/hacking/dotfiles/synergy.conf'
alias synergysdesktop='synergys -f --config ~/hacking/dotfiles/synergysdesktop.conf'
# Handles the laptop docking
alias undock="xrandr --output VGA1 --off"
alias dock="xrandr --output VGA1 --auto && xrandr --output VGA1 --right-of LVDS1"

# Handles django commom operations
alias runserver='python manage.py runserver'
alias syncdb='python manage.py syncdb'
alias shell='python manage.py shell'
alias dbshell='python manage.py dbshell'
alias pasteit='python ~/Dropbox/Hacking/pastebin.py'

# Cleans up ssh key
alias cleankey="keygone"
keygone() {
    sed -i -e "/^$1.*/D" ~/.ssh/known_hosts
}

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
alias branchme="parse_git_branch"

# postgres related
drop_db() {
    dropdb -Upostgres "$1"
}
alias dropit="drop_db"
alias dbuser='createuser -d -l -S -R $1 -Upostgres'
create_db() {
    createdb -U "$2" -O "$2" -EUTF8 "$1"
}
alias newdb='create_db'
reset_db() {
    dropdb -Upostgres "$1" && createdb -U "$2" -O "$2" -EUTF8 "$1"
}
alias resetdb='reset_db'

create_qemuimg() {
    qemu-img create "$1" 10G
}
alias qemuimg='create_qemuimg'
install_img() {
    sudo qemu-kvm -m 1024 -hda "$1" -cdrom $2  -boot d
}
alias qemuinstall='install_img'
boot_img() {
    sudo qemu-kvm -m 2048 -hda "$1" -boot c -soundhw ac97 -redir tcp:8080::80 -redir tcp:2222::22 -redir tcp:9999::3389
}
alias qemuboot='boot_img'

alias selenium='java -jar ~/Dropbox/Applications/selenium-server-standalone -trustAllSSLCertificates "*firefox"'
alias seleniumchrome='java -jar ~/Dropbox/Applications/selenium-server-standalone -trustAllSSLCertificates "*googlechrome /usr/bin/chromium-browser"'
#alias seleniumproxy='java -jar ~/Dropbox/Applications/selenium-server-standalone -trustAllSSLCertificates -forcedBrowserMode "*firefoxproxy /usr/lib64/firefox-8.0/firefox"'
alias gitpatch='git format-patch HEAD^'
alias lein='sh ~/Dropbox/Applications/lein'
alias clj='java -server -cp ~/Dropbox/Applications/clojure-1.3.0/clojure-1.3.0.jar clojure.main'

alias weather='python ~/Dropbox/Hacking/weather.py -l'
create_diary() {
    python ~/Dropbox/Hacking/diary.py -l "$1"
    vim `date +"%d-%m-%Y"`.log
}
alias diary='create_diary'
alias cidiary='hg ci -m "Entry for `date +"%d-%m-%Y"`."'

alias startvpn='./Dropbox/startvpn.sh  udp'
alias stopvpn='sudo killall openvpn 2>/dev/null'
alias syncdesk='rsync -av -e ssh ~/Documents cozinha:backup/.'
alias resyncdesk='rsync -av -e ssh cozinha:backup/Documents ~/.'
alias synclap='rsync -av -e ssh ~/.xchat2/xchatlogs cozinha:backup/chatlogs-laptop/.'
alias syncdrop='rsync -av -e ssh ~/Dropbox cozinha:backup/.'

# YOLO
#alias vim='emacs -nw'
alias emacs='emacs -nw'

#git remote add github git@github.com:omaciel/billreminder.git

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
rvm use 1.9.3

export EDITOR=vim
export SDL_AUDIODRIVER=pulse
export PYTHONPATH=/home/omaciel/hacking:/home/omaciel/Dropbox/Hacking:/home/omaciel
export PATH=$PATH:$HOME/.rvm/bin:$HOME/Dropbox/Applications:$HOME/bin
export QEMU_AUDIO_DRV=pa
export HEROKU_SSL_VERIFY=disable
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/jvm/jre/lib/amd64/
export PATH="$PATH:/usr/local/smlnj-110.75/bin" # Mac
export PATH="$PATH:/usr/share/smlnj" # Linux
export GPGKEY=D5CFC202
