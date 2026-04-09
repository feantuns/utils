#!/bin/bash
# =============================================================================
# Git Shell Aliases — Front-end Toolkit
# =============================================================================
# Como usar — adicione ao seu ~/.bashrc ou ~/.zshrc:
#
#   source /caminho/para/aliases/git-shell-aliases.sh
#
# Depois recarregue o terminal:
#   source ~/.zshrc  ou  source ~/.bashrc
# =============================================================================

# Atalho principal
alias g='git'

# --- Add ---
alias ga='git add -A'                          # adiciona tudo
alias gaf='git add'                            # adiciona arquivo específico

# --- Branch ---
alias gb='git branch -a'                       # lista todas as branches (local + remote)
alias gbl='git branch'                         # lista branches locais
alias gbdl='git branch -d'                     # deleta branch local (seguro)
alias gbdlh='git branch -D'                    # deleta branch local (forçado)
alias gbdr='git push origin --delete'          # deleta branch remota
alias gbrn='git branch -m'                     # renomeia branch

# --- Checkout ---
alias go='git checkout'                        # troca de branch ou restaura arquivo
alias gob='git checkout -b'                    # cria e entra em nova branch
alias gcf='git checkout -- .'                  # descarta todas as alterações locais

# Autocomplete para go e gob (bash)
if type __git_complete &>/dev/null; then
  __git_complete go _git_checkout
  __git_complete gob _git_checkout
fi

# --- Commit ---
alias gc='git commit'
alias gca='git commit --amend'
alias gagc='git add -A && git commit'          # add tudo + commit
alias gagca='git add -A && git commit --amend' # add tudo + amend

# --- Cherry-pick ---
alias gcp='git cherry-pick -x'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'

# --- Diff ---
alias gd='git diff'

# --- Log ---
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glc='git log --graph --abbrev-commit --decorate --date=relative --all'
alias gln='git log'

# --- Merge ---
alias gm='git merge --no-ff'
alias gma='git merge --abort'

# --- Pull / Push ---
alias gpl='git pull origin $(git branch --show-current)'   # pull da branch atual
alias gps='git push origin $(git branch --show-current)'   # push da branch atual
alias gpst='git push origin --tags'                        # push de todas as tags

# --- Rebase ---
alias greb='git rebase -i'

# --- Remote ---
alias gru='git remote update --prune'          # atualiza remotes e remove branches deletadas

# --- Reset ---
alias gunst='git reset HEAD'                   # unstage de arquivos

# --- Stash ---
alias gst='git stash'
alias gstl='git stash list'
alias gsta='git stash apply'
alias gstd='git stash drop'
alias gstp='git stash push -m'                 # stash com mensagem: gstp "wip: ajuste no header"

# --- Status ---
alias gs='git status'
alias gss='git status --short'

# --- Tags ---
alias gta='git tag -a'
alias gtd='git tag -d'
alias gtl99='git tag -n99'

# --- GUI ---
alias gk='gitk --all&'
alias gx='gitx --all'
