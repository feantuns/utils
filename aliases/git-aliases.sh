#!/bin/bash
# =============================================================================
# Git Aliases — Front-end Toolkit
# =============================================================================
# Como usar — execute uma vez para registrar os aliases no git global:
#
#   bash aliases/git-aliases.sh
#
# Após isso, os comandos ficam disponíveis em qualquer repositório:
#   git conflicts <branch>
#   git pr <branch>
# =============================================================================

# -----------------------------------------------------------------------------
# git conflicts <branch-destino>
#
# Faz push da branch atual e verifica se há conflitos com a branch destino,
# sem realizar o merge de fato.
#
# Uso: git conflicts main
# -----------------------------------------------------------------------------
git config --global alias.conflicts '!f() {
  target_branch="$1"

  if [ -z "$target_branch" ]; then
    echo "❌ Informe a branch destino. Uso: git conflicts <branch>"
    return 1
  fi

  current_branch=$(git symbolic-ref --short HEAD 2>/dev/null)

  echo "📤 Fazendo push de \"$current_branch\"..."
  git push origin "$current_branch" || { echo "❌ Falha no push."; return 1; }

  echo "🔍 Verificando conflitos entre \"$current_branch\" e \"$target_branch\"..."
  git fetch origin "$target_branch" --quiet

  git merge --no-commit --no-ff "origin/$target_branch" > /dev/null 2>&1
  conflicts=$(git ls-files --unmerged | wc -l | tr -d " ")

  if [ "$conflicts" -gt 0 ]; then
    echo ""
    echo "⚠️  Conflitos encontrados com \"$target_branch\":"
    git ls-files --unmerged | awk "{print \$4}" | sort -u | sed "s/^/   • /"
  else
    echo "✅ Nenhum conflito com \"$target_branch\"."
  fi

  git merge --abort 2>/dev/null
  git reset --merge 2>/dev/null
}; f'

# -----------------------------------------------------------------------------
# git pr <branch-destino>
#
# Faz push da branch atual e abre o modo interativo do GitHub CLI para
# preencher título, body, reviewers, etc. Printa o link do PR no terminal.
#
# Requer: gh (GitHub CLI) — https://cli.github.com
# Uso: git pr main
# -----------------------------------------------------------------------------
git config --global alias.pr '!f() {
  target_branch="$1"

  if [ -z "$target_branch" ]; then
    echo "❌ Informe a branch destino. Uso: git pr <branch>"
    return 1
  fi

  if ! command -v gh > /dev/null 2>&1; then
    echo "❌ GitHub CLI (gh) não encontrado."
    echo "   Instale em: https://cli.github.com"
    return 1
  fi

  current_branch=$(git symbolic-ref --short HEAD 2>/dev/null)

  echo "📤 Fazendo push de \"$current_branch\"..."
  git push origin "$current_branch" || { echo "❌ Falha no push."; return 1; }

  echo ""
  echo "🔗 Criando Pull Request para \"$target_branch\"..."
  echo ""

  # Roda sem capturar output para preservar o TTY e ativar o modo interativo do gh
  gh pr create --base "$target_branch" --head "$current_branch"
  exit_code=$?

  if [ $exit_code -ne 0 ]; then
    echo "❌ Falha ao criar o PR."
    return 1
  fi

  pr_link=$(gh pr view --json url -q ".url" 2>/dev/null)
  echo ""
  echo "✅ Pull Request criado com sucesso!"
  echo "🔗 $pr_link"
}; f'

echo "✅ Aliases registrados com sucesso!"
echo "   git conflicts <branch>"
echo "   git pr <branch>"
