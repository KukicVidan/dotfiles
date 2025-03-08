# Config file for Powerlevel10k with the style of Pure (https://github.com/sindresorhus/pure).
# Updated Git status indicators with colored text (instead of background colors).

# Temporarily change options.
'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
  emulate -L zsh -o extended_glob

  # Unset all configuration options.
  unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'

  # Zsh >= 5.1 is required.
  [[ $ZSH_VERSION == (5.<1->*|<6->.*) ]] || return

  # Prompt colors.
  local grey='242'
  local red='1'
  local yellow='3'
  local blue='4'
  local magenta='5'
  local cyan='6'
  local white='7'
  local green='2'

  # Left prompt segments.
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    dir                       # current directory
    vcs                       # git status
    newline                   # \n
    prompt_char               # prompt symbol
  )

  # Right prompt segments.
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    command_execution_time    # previous command duration
    virtualenv                # python virtual environment
    #context                   # user@host
    time                      # current time
    newline                   # \n
  )

  # Basic style options.
  typeset -g POWERLEVEL9K_BACKGROUND=                            # transparent background
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_{LEFT,RIGHT}_WHITESPACE=  # no surrounding whitespace
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=' '  # separate segments with a space
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SEGMENT_SEPARATOR=        # no end-of-line symbol
  typeset -g POWERLEVEL9K_VISUAL_IDENTIFIER_EXPANSION=           # no segment icons

  # Add an empty line before each prompt except the first.
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

  # Magenta prompt symbol if last command succeeded.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS}_FOREGROUND=$magenta
  # Red prompt symbol if last command failed.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS}_FOREGROUND=$red
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='❮'

  # Blue current directory.
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=$blue

  # Git status color and icons (only text color, no background color changes)
  typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=$green          # Green when clean
  typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=$yellow       # Yellow when modified
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=$red         # Red for untracked files
  typeset -g POWERLEVEL9K_VCS_CONFLICTED_FOREGROUND=$red        # Red for conflicts
  typeset -g POWERLEVEL9K_VCS_LOADING_FOREGROUND=$grey          # Grey when loading

  typeset -g POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON="%F{cyan}⇣%f"
  typeset -g POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON="%F{yellow}⇡%f"
  typeset -g POWERLEVEL9K_VCS_STAGED_ICON="%F{blue}%f"
  typeset -g POWERLEVEL9K_VCS_UNSTAGED_ICON="%F{red}%f"
  #typeset -g POWERLEVEL9K_VCS_DIRTY_ICON="%F{red}%f"
  typeset -g POWERLEVEL9K_VCS_COMMIT_ICON="%F{cyan}%f"

  # Git status display format
   POWERLEVEL9K_VCS_SHOW_NUMBERS=true
   POWERLEVEL9K_VCS_ICON_BEFORE_STATUS=true
   POWERLEVEL9K_VCS_SHOW_STAGED=true
   POWERLEVEL9K_VCS_SHOW_UNSTAGED=true


  # Grey current time.
  typeset -g POWERLEVEL9K_TIME_FOREGROUND=$grey
  typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'
  typeset -g POWERLEVEL9K_TIME_UPDATE_ON_COMMAND=false

  # Instant prompt mode.
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose

  # If p10k is already loaded, reload configuration.
  (( ! $+functions[p10k] )) || p10k reload
}

# Tell `p10k configure` which file it should overwrite.
typeset -g POWERLEVEL9K_CONFIG_FILE=${${(%):-%x}:a}

(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'



