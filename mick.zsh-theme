
prompt_setup_pygmalion(){
  ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}⇒ %{$reset_color%}%{$reset_color%}%{$fg[blue]%}"
  ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
  ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%} ✗✗✗%{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ✔%{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%}+ %{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%}▲ %{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✖ %{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}➜ %{$reset_color%}"


  base_prompt='%{$fg[green]%}%n%{$reset_color%}%{$fg[green]%}@%{$reset_color%}%{$fg[green]%}%m%{$reset_color%}%{$fg[green]%}:%{$reset_color%}%{$fg[green]%}%0~%{$reset_color%}%{$fg[green]%}|%{$reset_color%}'
  post_prompt='%{$fg[green]%}⇒ $%{$reset_color%}'

  base_prompt_nocolor=$(echo "$base_prompt" | perl -pe "s/%\{[^}]+\}//g")
  post_prompt_nocolor=$(echo "$post_prompt" | perl -pe "s/%\{[^}]+\}//g")

  precmd_functions+=(prompt_pygmalion_precmd)
}

prompt_pygmalion_precmd(){
  local gitinfo=$(git_prompt_info)
  local gitinfo_nocolor=$(echo "$gitinfo" | perl -pe "s/%\{[^}]+\}//g")
  local exp_nocolor="$(print -P \"$base_prompt_nocolor$gitinfo_nocolor$post_prompt_nocolor\")"
  local prompt_length=${#exp_nocolor}

  local nl=""

  if [[ $prompt_length -gt 40 ]]; then
    nl=$'\n%{\r%}';
  fi
  PROMPT="$base_prompt$gitinfo$nl$post_prompt"
}

prompt_setup_pygmalion
