# Git Config {{{
# ###################################################################

bot "OK, now I am going to configure your gitconfig"
gitconfdir="$HOME/.config/git/"
homegitconf="$HOME/.gitconfig"

function updateconfig() {
  mkdir -p $gitconfdir
  cp -r ./config/git/* $gitconfdir
  bot "I can update your config file with your user info"

  username=`grep "name" ${gitconfig}/config | cut -d\  -f3`
  info "currently your user name is ${username}."
  read -r -p "do you want to change it? [y|N] " response
  if [[ $response =~ (yes|y|Y) ]];then
    read -r -p "What is your new user name? " uname
  else
    uname=$username
  fi

  useremail=`grep "email" ${gitconfig}/config | cut -d\  -f3`
  info "currently your user name is ${useremail}."
  read -r -p "do you want to change it? [y|N] " response
  if [[ $response =~ (yes|y|Y) ]];then
    read -r -p "What is your new user name? " uemail
  else
    uemail=$useremail
  fi

  sed 's/${username}/${uname}/; s/${useremail}/${uemail}' ${gitconfig}/config > tmp.txt
  mv tmp.txt ${gitconfig}/config
  bot "finnished updating config"
}

if [ -f "$homegitconf" ];then
  bot "gitconfig found at $homegitconf, do you want to replace it with the one I recommend?"
  read -r -p "Remove $homegitconf and copy ./config/git to $gitconfdir? [y|N] " response
  if [[ $response =~ (yes|y|Y) ]];then
    rm $homegitconf
    updateconfig
  else
    ok "skipped"
  fi
elif [ -f "${gitconfdir}/config" ];then
  bot "config file found at ${gitconfdir}/config, do you want to replace it with the one I reccomend?"
  read -r -p "replace $gitconfdir with ./config/git? [y|N] " response
  if [[ $response =~ (yes|y|Y) ]];then
    updateconfig
  else
    ok "skipped"
  fi
else
  info "cannot find existing gitconfig file, copying default config to $gitconfdir"
  updateconfig
fi

###################################################################}}}

