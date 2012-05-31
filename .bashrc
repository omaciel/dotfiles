#!/bin/bash -x

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ -f ~/.bash_profile ]; then
    source ~/.bash_profile
else
    if [ -f /etc/profile ];then
        source /etc/profile
    fi
fi

unset LS_COLORS
export EDITOR="vim"
export BROWSER=/usr/bin/chromium-browser
export OOO_FORCE_DESKTOP=gnome
export SDL_AUDIODRIVER=pulse
export PYTHONPATH=/home/omaciel/hacking:/home/omaciel/Dropbox/Hacking:/home/omaciel
export PATH=$PATH:$HOME/.rvm/bin:$HOME/Dropbox/Applications
export QEMU_AUDIO_DRV=pa
export HEROKU_SSL_VERIFY=disable

# User specific aliases and functions
alias ls='ls --color -F'
alias grep='grep --color=tty -d skip'

alias clonefoo="git clone gnome:$1"
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
alias updateall='sudo conary updateall --no-interactive'

alias cleanpyc='find . -iname "*.pyc" | xargs rm'
alias proj='xrandr --output VGA --mode 1024x768 --output LVDS --auto'
alias int='xrandr --output VGA --off --output LVDS --auto'
alias ext='xrandr --output VGA --auto --output LVDS --auto'

alias synergyslaptop='synergys -f --config ~/hacking/dotfiles/config/synergy.conf'
alias synergysdesktop='synergys -f --config ~/hacking/dotfiles/config/synergysdesktop.conf'
alias synergyclaptop='synergyc -f 10.11.230.241'

findandreplace() {
    find ./ -type f -exec sed -i 's/$1/$2' {} ;
}
alias findreplace='findandreplace'

emailpatch() {
    hg email -r $1  -t diegobz@indifex.com -c glezos@indifex.com
}
alias txemail='emailpatch'

# Function to autocomplete ssh hosts
_compssh ()
{
cur=${COMP_WORDS[COMP_CWORD]};
COMPREPLY=($(compgen -W '$(cat ${HOME}/.ssh/config | grep "^Host\b" - | sed -e "s/Host //")' -- $cur))
}
complete -F _compssh ssh

# Handles the laptop docking
alias undock="xrandr --output VGA1 --off"
alias dock="xrandr --output VGA1 --auto && xrandr --output VGA1 --right-of LVDS1"

# Handles django commom operations
alias runserver='python manage.py runserver'
alias syncdb='python manage.py syncdb'
alias shell='python manage.py shell'
alias dbshell='python manage.py dbshell'
alias pasteit='python ~/Dropbox/Hacking/pastebin.py'

# SSH into rPath QA systems using QA sshkeys
alias sshqa='ssh -i ~/hacking/app-test/automation/conf/.ssh/qa -l root $1 -v'

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
alias branchme="parse_git_branch"

# rmake foresight packages
mook_package() {
  rmake build --context fl:2-devel "$1{x86}" "$1{x86_64}"
}
alias mookme="mook_package"

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
alias ubuntu='vncviewer -geometry 1280x1024 dhcp214.rdu.rpath.com'

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
alias sshqa='ssh -i ~/Dropbox/work/demo-key root@'

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

alias syncdesk='rsync -av -e ssh ~/.xchat2 cozinha:backup/chatlogs-desktop/.'
alias resyncdesk='rsync -av -e ssh cozinha:backup/chatlogs-desktop/.xchat2 ~/.'
alias synclap='rsync -av -e ssh ~/.xchat2/xchatlogs cozinha:backup/chatlogs-laptop/.'
alias syncdrop='rsync -av -e ssh ~/Dropbox cozinha:backup/.'

#git remote add github git@github.com:omaciel/billreminder.git

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
rvm use 1.9.3
