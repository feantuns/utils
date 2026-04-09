#!/bin/bash
# =============================================================================
# Git Aliases — Front-end Toolkit
# =============================================================================
# Como usar:
#   source ~/.bashrc  ou  source ~/.zshrc
#
# Adicione ao seu ~/.bashrc ou ~/.zshrc:
#   source /caminho/para/este/arquivo/git-aliases.sh
# =============================================================================

# -----------------------------------------------------------------------------
# git conflicts <branch-destino>
#
# Faz push da branch atual e verifica se há conflitos com a branch destino,
# sem realizar o merge de fato.
#
# Uso: git conflicts main
# -----------------------------------------------------------------------------
git_conflicts() {
  local target_branch="$1"

  if [ -z "$target_branch" ]; then
    echo "❌ Informe a branch destino. Uso: git conflicts <branch>"
    return 1
  fi

  local current_branch
  current_branch=$(git symbolic-ref --short HEAD 2>/dev/null)

  if [ -z "$current_branch" ]; then
    echo "❌ Não foi possível identificar a branch atual."
    return 1
  fi

  echo "📤 Fazendo push de '$current_branch'..."
  if ! git push origin "$current_branch"; then
    echo "❌ Falha no push."
    return 1
  fi

  echo "🔍 Verificando conflitos entre '$current_branch' e '$target_branch'..."

  # Garante que a branch destino está atualizada localmente
  git fetch origin "$target_branch" --quiet

  # Tenta o merge em modo dry-run (sem commit, sem fast-forward)
  if git merge --no-commit --no-ff "origin/$target_branch" > /dev/null 2>&1; then
    local conflicts
    conflicts=$(git ls-files --unmerged | wc -l | tr -d ' ')

    if [ "$conflicts" -gt 0 ]; then
      echo ""
      echo "⚠️  Conflitos encontrados com '$target_branch':"
      git ls-files --unmerged | awk '{print $4}' | sort -u | sed 's/^/   • /'
    else
      echo "✅ Nenhum conflito com '$target_branch'."
    fi
  else
    echo ""
    echo "⚠️  Conflitos encontrados com '$target_branch':"
    git ls-files --unmerged | awk '{print $4}' | sort -u | sed 's/^/   • /'
  fi

  # Sempre aborta o merge para não deixar o repositório em estado sujo
  git merge --abort 2>/dev/null
  git reset --merge 2>/dev/null
  return 0
}

# -----------------------------------------------------------------------------
# git pr <branch-destino>
#
# Faz push da branch atual e cria um Pull Request via GitHub CLI (gh),
# sem abrir o navegador. Printa o link do PR criado no terminal.
#
# Requer: gh (GitHub CLI) — https://cli.github.com
# Uso: git pr main
# -----------------------------------------------------------------------------
git_pr() {
  local target_branch="$1"

  if [ -z "$target_branch" ]; then
    echo "❌ Informe a branch destino. Uso: git pr <branch>"
    return 1
  fi

  if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) não encontrado."
    echo "   Instale em: https://cli.github.com"
    return 1
  fi

  local current_branch
  current_branch=$(git symbolic-ref --short HEAD 2>/dev/null)

  if [ -z "$current_branch" ]; then
    echo "❌ Não foi possível identificar a branch atual."
    return 1
  fi

  echo "📤 Fazendo push de '$current_branch'..."
  if ! git push origin "$current_branch"; then
    echo "❌ Falha no push."
    return 1
  fi

  echo "🔗 Criando Pull Request para '$target_branch'..."

  local pr_url
  pr_url=$(gh pr create \
    --base "$target_branch" \
    --head "$current_branch" \
    --fill \
    --no-maintainer-edit \
    2>&1)

  local exit_code=$?

  if [ $exit_code -ne 0 ]; then
    echo "❌ Falha ao criar o PR:"
    echo "   $pr_url"
    return 1
  fi

  # Extrai apenas a URL do output do gh
  local pr_link
  pr_link=$(echo "$pr_url" | grep -Eo 'https://github\.com[^ ]+')

  echo ""
  echo "✅ Pull Request criado com sucesso!"
  echo "🔗 $pr_link"
  return 0
}

# -----------------------------------------------------------------------------
# Registra os aliases no git via funções shell
# (git não suporta funções shell diretamente, então usamos alias de shell
#  que chamam as funções acima)
# -----------------------------------------------------------------------------
alias git-conflicts=git_conflicts
alias git-pr=git_pr

# Atalhos no estilo "git conflicts" e "git pr" usando git alias + shell function
# Adiciona automaticamente ao gitconfig global se ainda não existir
_register_git_aliases() {
  if ! git config --global alias.conflicts &>/dev/null; then
    git config --global alias.conflicts '!git_conflicts() { /bin/bash -c "source '"$(realpath "$0" 2>/dev/null || echo "$BASH_SOURCE")"' && git_conflicts \"$1\"" -- "$@"; }; git_conflicts'
  fi
}

# Para usar como "git conflicts" e "git pr" no terminal,
# os aliases abaixo sobrescrevem o comportamento do comando git via shell:
git() {
  if [ "$1" = "conflicts" ]; then
    shift
    git_conflicts "$@"
  elif [ "$1" = "pr" ]; then
    shift
    git_pr "$@"
  else
    command git "$@"
  fi
}
