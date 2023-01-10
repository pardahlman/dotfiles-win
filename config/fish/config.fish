if status is-interactive
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    starship init fish | source
end
