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

### [`git-aliases.sh`](./aliases/git-aliases.sh)

Aliases para o git que estendem o CLI com comandos customizados.

**Como instalar:**

Execute uma vez para registrar os aliases no git global:

```bash
bash aliases/git-aliases.sh
```

Pronto — os comandos ficam disponíveis em qualquer repositório, sem precisar de nada no `.bashrc` ou `.zshrc`.

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

Faz push da branch atual e cria um Pull Request via [GitHub CLI](https://cli.github.com), sem abrir o navegador. Printa o link do PR no terminal.

> Requer `gh` instalado e autenticado: `gh auth login`

```bash
git pr main
```

```
📤 Fazendo push de 'feat/minha-feature'...
🔗 Criando Pull Request para 'main'...

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
