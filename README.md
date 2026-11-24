# mac-bootstrap

Bootstrap a fresh Apple Silicon Mac using Homebrew and chezmoi. You’ll need a GitHub account with access to the private `ihandley/dotfiles` repository.

## 1. Run bootstrap

From a local copy of this repository, run:

```sh
bash bootstrap.sh
```

If macOS prompts you to install the Xcode Command Line Tools, finish the installation and rerun the script. Bootstrap sets up Homebrew, installs GitHub CLI and chezmoi, and prompts you to sign in to GitHub if needed. It clones the private dotfiles repository on the first run and uses a fast-forward-only pull on subsequent runs. The chezmoi apply is scoped to `~/src`, including `~/src/personal` and `~/src/work`.

## 2. Install the packages in the Brewfile

After bootstrap completes, open a new terminal or load Homebrew into your current shell if `brew` is unavailable:

```sh
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Run Homebrew Bundle against the Brewfile in the dotfiles checkout:

```sh
brew bundle install --no-upgrade --file="$(chezmoi source-path)/Brewfile"
```

This installs missing packages and skips routine upgrades. Rerun the command after changing the Brewfile or to restore a missing package.
