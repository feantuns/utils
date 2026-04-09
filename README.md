# 🧰 Front-end Toolkit

Uma coletânea de scripts, aliases, snippets e configurações que acumulei ao longo da carreira como desenvolvedor front-end. Tudo aqui já resolveu um problema real — talvez resolva o seu também.

---

## 📁 Estrutura

```
.
├── scripts/        # Scripts Node.js e shell para automação de tarefas
├── aliases/        # Aliases de terminal para git, npm e outros
├── snippets/       # Snippets de código reutilizáveis (hooks, utils, componentes)
└── configs/        # Arquivos de configuração prontos para uso (ESLint, TSConfig, etc.)
```

---

## 🚀 Scripts

| Arquivo | Descrição |
|---|---|
| [`run-tests-only-changed.js`](./scripts/run-tests-only-changed.js) | Executa testes apenas nos arquivos modificados em relação à branch de origem |

### Como usar `run-tests-only-changed.js`

Roda os testes somente dos arquivos alterados na branch atual comparando com `master` (ou outra branch passada como argumento).

```bash
# Comparando com master (padrão)
node scripts/run-tests-only-changed.js

# Comparando com outra branch
node scripts/run-tests-only-changed.js develop
```

> Requer `git` e `npm run test:ci` configurado no projeto.

---

## ⚡ Aliases

### [`git-shell-aliases.sh`](./aliases/git-shell-aliases.sh)

Aliases de shell para o dia a dia com git. Adicione ao seu `~/.zshrc` ou `~/.bashrc`:

```bash
source /caminho/para/aliases/git-shell-aliases.sh
```

Depois recarregue o terminal:

```bash
source ~/.zshrc  # ou ~/.bashrc
```

**Aliases mais usados:**

`go` — troca de branch

```bash
go feat/minha-feature
go main
```

`gob` — cria e entra em nova branch

```bash
gob feat/novo-componente
```

`gps` — push da branch atual (sem precisar digitar o nome)

```bash
gps
# equivale a: git push origin feat/novo-componente
```

`gpl` — pull da branch atual

```bash
gpl
# equivale a: git pull origin feat/novo-componente
```

`gl` — log visual com grafo, autor e tempo relativo

```bash
gl
# * a1b2c3d - (HEAD -> feat/x) fix: ajuste no layout (2 hours ago) <João>
# * d4e5f6g - (main) feat: adiciona componente Button (1 day ago) <Maria>
```

`gagc` — add tudo e commita de uma vez

```bash
gagc -m "feat: adiciona header responsivo"
```

`gstp` — stash com mensagem descritiva

```bash
gstp "wip: ajuste no modal"
```

`gss` — status resumido

```bash
gss
#  M src/components/Header.tsx
# ?? src/components/NewFile.tsx
```

Tabela completa:

| Alias | Comando |
|---|---|
| `g` | `git` |
| `ga` | `git add -A` |
| `gaf` | `git add` |
| `gb` | `git branch -a` |
| `gbl` | `git branch` |
| `gbdl` | `git branch -d` |
| `gbdlh` | `git branch -D` |
| `gbdr` | `git push origin --delete` |
| `gbrn` | `git branch -m` |
| `go` | `git checkout` |
| `gob` | `git checkout -b` |
| `gcf` | `git checkout -- .` |
| `gc` | `git commit` |
| `gca` | `git commit --amend` |
| `gagc` | `git add -A && git commit` |
| `gagca` | `git add -A && git commit --amend` |
| `gcp` | `git cherry-pick -x` |
| `gcpa` | `git cherry-pick --abort` |
| `gcpc` | `git cherry-pick --continue` |
| `gd` | `git diff` |
| `gl` | log com grafo e formatação |
| `glc` | log com grafo e datas relativas |
| `gln` | `git log` |
| `gm` | `git merge --no-ff` |
| `gma` | `git merge --abort` |
| `gpl` | `git pull origin <branch-atual>` |
| `gps` | `git push origin <branch-atual>` |
| `gpst` | `git push origin --tags` |
| `greb` | `git rebase -i` |
| `gru` | `git remote update --prune` |
| `gunst` | `git reset HEAD` |
| `gst` | `git stash` |
| `gstl` | `git stash list` |
| `gsta` | `git stash apply` |
| `gstd` | `git stash drop` |
| `gstp` | `git stash push -m` |
| `gs` | `git status` |
| `gss` | `git status --short` |
| `gta` | `git tag -a` |
| `gtd` | `git tag -d` |
| `gtl99` | `git tag -n99` |

---

### [`git-aliases.sh`](./aliases/git-aliases.sh)

Comandos customizados registrados no git global via `git config`. Execute uma vez:

```bash
bash aliases/git-aliases.sh
```

---

**`git conflicts <branch-destino>`**

Faz push da branch atual e verifica se há conflitos com a branch destino, sem realizar o merge de fato.

```bash
git conflicts main
```

```
📤 Fazendo push de 'feat/minha-feature'...
🔍 Verificando conflitos entre 'feat/minha-feature' e 'main'...
⚠️  Conflitos encontrados com 'main':
   • src/components/Button.tsx
   • src/styles/global.css
```

---

**`git pr <branch-destino>`**

Faz push da branch atual e abre o modo interativo do [GitHub CLI](https://cli.github.com) para preencher título, body, reviewers, etc. Printa o link do PR no terminal.

> Requer `gh` instalado e autenticado: `gh auth login`

```bash
git pr main
```

```
📤 Fazendo push de 'feat/minha-feature'...
🔗 Criando Pull Request para 'main'...

? Title: feat: adiciona header responsivo
? Body: [(e) to launch nano, enter to skip]
? What's next? Submit

✅ Pull Request criado com sucesso!
🔗 https://github.com/usuario/repo/pull/42
```

---

## 🧩 Snippets

Em breve — hooks React, funções utilitárias, componentes base e mais.

---

## ⚙️ Configs

Em breve — configurações de ESLint, Prettier, TypeScript e outras ferramentas.

---

## 🤝 Contribuindo

Encontrou algo útil que deveria estar aqui? Fique à vontade para abrir uma PR ou issue.

1. Fork o repositório
2. Crie uma branch: `git checkout -b feat/meu-script`
3. Commit suas mudanças: `git commit -m 'feat: adiciona script X'`
4. Push: `git push origin feat/meu-script`
5. Abra uma Pull Request

---

## 📄 Licença

MIT — use à vontade.
