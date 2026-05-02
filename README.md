# shell-prefs

Personal zsh configuration with oh-my-zsh, vi-mode, and modern CLI replacements.

## What's included

- **zshrc** — oh-my-zsh setup, fzf, virtualenvwrapper, zoxide
- **aliases** — `ls` → eza, `cat` → bat
- **functions** — kube_ps1 toggle, claude() iTerm2 tab title wrapper
- **blinks-patch** — custom zsh theme
- **plugins** — zsh-autosuggestions, zsh-vi-mode, zsh-syntax-highlighting, bgnotify-clone (submodules)

## Setup

```bash
# clone with submodules
git clone --recursive <repo-url> ~/Projects/shell-prefs

# install brew dependencies
./setup.sh

# symlink into place
ln -sf ~/Projects/shell-prefs/.zshrc ~/.zshrc
ln -sf ~/Projects/shell-prefs/.oh-my-zsh-custom ~/.oh-my-zsh-custom
```

Optionally, for work-specific overrides, clone a separate private repo to `~/Projects/shell-prefs-sfdc/` — it will be sourced automatically if present.
