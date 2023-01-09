# Setting up WSL

Automatically setting up WSL is only partly implemented. Several manual steps are required at this point.

## Installing WSL

Following the [official documentation](https://learn.microsoft.com/en-us/windows/wsl/install), install WSL using the following command

```pwsh
wsl --install Ubuntu
```

(Note, to uninstall use `wsl --unregister Ubuntu`)

### Setting up dotfiles

Run `wsl.ps1`. It will ask for `sudo` one or more times and also ask you to press enter while installing Homebrew.
