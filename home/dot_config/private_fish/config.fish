starship init fish | source

if status is-interactive
    # Commands to run in interactive sessions can go here
end

export EDITOR="nvim"

alias ls="eza --icons"
alias find="fd"
alias grep"rg"
alias ps="procs"
alias history="histdb"
alias commit="cz"
alias yt-dlp="yt-dlp --concurrent-fragments 3"
alias youtube-dl="yt-dlp"
alias pacman="yay"
alias generate-server="npx npx-server"
alias ips='ip -c -br a'
alias pid='pgrep'
alias cat='bat'
alias ports='sudo netstat -tulanp'
alias hg='history|grep'
alias mkdir='mkdir -pv'
alias eas='npx eas-cli'
alias npx='pnpm --silent dlx'
alias edit="$EDITOR"
alias zconfig='lvim ~/.zshrc'
alias zcompletions='cd /usr/local/share/zsh/site-functions/'
alias cmedit="chezmoi edit --watch"
alias cd="z"
alias docker="podman"

export PATH="$PATH:/home/mateusfg7/.local/bin"
export PATH="$PATH:/home/mateusfg7/Scripts"

export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$PATH:$ANDROID_HOME/emulator"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$HOME/.local/bin"

set --export WEECHAT_HOME "~/.weechat"

export SSH_AUTH_SOCK=~/.1password/agent.sock

# Bun Config
set --export BUN_INSTALL $HOME/.bun
set --export PATH $BUN_INSTALL/bin:$PATH

fzf --fish | source
zoxide init --cmd cd fish | source
mise activate fish | source
op completion fish | source

# RUSTUP
set -e RUSTUP_TOOLCHAIN

# PNPM
set -gx PNPM_HOME "/home/mateus/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
