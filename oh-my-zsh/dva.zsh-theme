local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

# Characters
SEP=⚡

PROMPT='%{$FG[212]%}%n%{$reset_color%}$SEP%{$FG[231]%}%m\
%{$reset_color%}:%{$fg[magenta]%}%~\
$(git_prompt_info) \
%{$fg[red]%}%(!.#.»)%{$reset_color%} '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='${return_code}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}○%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}⚡%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[yellow]%})%{$reset_color%}"
