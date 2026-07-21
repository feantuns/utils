# 🧰 Front-end Toolkit

A collection of scripts, aliases, snippets, and configs I've gathered throughout my career as a front-end developer. Everything here has solved a real problem — maybe it'll solve yours too.

---

## 📁 Structure

```
.
├── scripts/        # Node.js and shell scripts for task automation
├── aliases/        # Terminal aliases for git, npm, and more
├── skills/         # Agent skills for Kiro IDE
├── snippets/       # Reusable code snippets (hooks, utils, components)
└── configs/        # Ready-to-use config files (ESLint, TSConfig, etc.)
```

---

## 🚀 Scripts

| File | Description |
|---|---|
| [`run-tests-only-changed.js`](./scripts/run-tests-only-changed.js) | Runs tests only for files changed in the current branch compared to the base branch |

### How to use `run-tests-only-changed.js`

Runs tests only for files changed in the current branch, comparing against `master` (or another branch passed as an argument).

```bash
# Compare against master (default)
node scripts/run-tests-only-changed.js

# Compare against another branch
node scripts/run-tests-only-changed.js develop
```

> Requires `git` and `npm run test:ci` configured in the project.

---

## ⚡ Aliases

### [`git-shell-aliases.sh`](./aliases/git-shell-aliases.sh)

Shell aliases for everyday git usage. Add to your `~/.zshrc` or `~/.bashrc`:

```bash
source /path/to/aliases/git-shell-aliases.sh
```

Then reload your terminal:

```bash
source ~/.zshrc  # or ~/.bashrc
```

**Most used aliases:**

`go` — switch branches

```bash
go feat/my-feature
go main
```

`gob` — create and switch to a new branch

```bash
gob feat/new-component
```

`gps` — push current branch (no need to type the branch name)

```bash
gps
# equivalent to: git push origin feat/new-component
```

`gpl` — pull current branch

```bash
gpl
# equivalent to: git pull origin feat/new-component
```

`gl` — visual log with graph, author and relative time

```bash
gl
# * a1b2c3d - (HEAD -> feat/x) fix: layout adjustment (2 hours ago) <John>
# * d4e5f6g - (main) feat: add Button component (1 day ago) <Jane>
```

`gagc` — stage everything and commit in one shot

```bash
gagc -m "feat: add responsive header"
```

`gstp` — stash with a descriptive message

```bash
gstp "wip: modal adjustment"
```

`gss` — short status

```bash
gss
#  M src/components/Header.tsx
# ?? src/components/NewFile.tsx
```

Full reference:

| Alias | Command |
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
| `gl` | graph log with formatting |
| `glc` | graph log with relative dates |
| `gln` | `git log` |
| `gm` | `git merge --no-ff` |
| `gma` | `git merge --abort` |
| `gpl` | `git pull origin <current-branch>` |
| `gps` | `git push origin <current-branch>` |
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

Custom git commands registered globally via `git config`. Run once to install:

```bash
bash aliases/git-aliases.sh
```

---

**`git conflicts <target-branch>`**

Pushes the current branch and checks for conflicts against the target branch, without actually performing the merge.

```bash
git conflicts main
```

```
📤 Pushing 'feat/my-feature'...
🔍 Checking conflicts between 'feat/my-feature' and 'main'...
⚠️  Conflicts found with 'main':
   • src/components/Button.tsx
   • src/styles/global.css
```

---

**`git pr <target-branch>`**

Pushes the current branch and opens the interactive [GitHub CLI](https://cli.github.com) prompt to fill in the title, body, reviewers, etc. Prints the PR link in the terminal when done.

> Requires `gh` installed and authenticated: `gh auth login`

```bash
git pr main
```

```
📤 Pushing 'feat/my-feature'...
🔗 Creating Pull Request targeting 'main'...

? Title: feat: add responsive header
? Body: [(e) to launch nano, enter to skip]
? What's next? Submit

✅ Pull Request created successfully!
🔗 https://github.com/user/repo/pull/42
```

---

## 🤖 Skills

### [`skills/`](./skills/)

A collection of agent skills — structured instructions that give AI agents context and behavior for specific tasks. Compatible with AI coding agents that support the skill/context file convention.

| Skill | Description |
|---|---|
| [`claude-api`](./skills/claude-api/) | Build apps with the Claude API or Anthropic SDK |
| [`cloudflare`](./skills/cloudflare/) | Cloudflare platform — Workers, Pages, KV, D1, R2, AI, and more |
| [`cria-prd`](./skills/cria-prd/) | Creates Product Requirements Documents (PRDs) from feature requests |
| [`cria-techspec`](./skills/cria-techspec/) | Creates Technical Specs from existing PRDs |
| [`criar-tasks`](./skills/criar-tasks/) | Converts PRD + Tech Spec into a sequenced list of implementation tasks |
| [`executar-bugfix`](./skills/executar-bugfix/) | Reads bugs.md, analyzes root causes, implements fixes and regression tests |
| [`executar-qa`](./skills/executar-qa/) | Validates implementation via E2E tests, accessibility (WCAG 2.2), and visual analysis |
| [`executar-review`](./skills/executar-review/) | Code review against project rules, test suites, and Tech Spec |
| [`executar-task`](./skills/executar-task/) | Implements feature tasks from PRD/TechSpec context |
| [`frontend-design`](./skills/frontend-design/) | Creates distinctive, production-grade frontend interfaces |
| [`hono`](./skills/hono/) | Develop Hono applications — docs search, API reference, request testing |
| [`prompt-enhancement`](./skills/prompt-enhancement/) | Transforms vague prompts into structured prompts using XML and Markdown |
| [`shadcn`](./skills/shadcn/) | Manages shadcn/ui components — adding, styling, composing, and debugging |
| [`skill-best-practices`](./skills/skill-best-practices/) | Authors professional-grade agent skills following the agentskills.io spec |
| [`task-review`](./skills/task-review/) | Reviews completed task implementations against code standards and test suites |
| [`ui-ux-pro-max`](./skills/ui-ux-pro-max/) | UI/UX design intelligence — 50+ styles, 161 palettes, 57 font pairings, and more |
| [`vercel-composition-patterns`](./skills/vercel-composition-patterns/) | Vercel component composition patterns |
| [`vercel-react-best-practices`](./skills/vercel-react-best-practices/) | React and Next.js performance optimization guidelines from Vercel Engineering |
| [`web-design-guidelines`](./skills/web-design-guidelines/) | Reviews UI code for Web Interface Guidelines and accessibility compliance |

**How to install a skill:**

```bash
# Install a single skill
cp -r skills/frontend-design ~/.kiro/skills/

# Install all skills at once
cp -r skills/* ~/.kiro/skills/
```

> The path above is for Kiro. Check your AI agent's documentation for the correct skills directory.

---

## 🧩 Snippets

Coming soon — React hooks, utility functions, base components, and more.

---

## ⚙️ Configs

Coming soon — ESLint, Prettier, TypeScript, and other tool configurations.

---

## 🤝 Contributing

Found something useful that should be here? Feel free to open a PR or issue.

1. Fork the repository
2. Create a branch: `git checkout -b feat/my-script`
3. Commit your changes: `git commit -m 'feat: add script X'`
4. Push: `git push origin feat/my-script`
5. Open a Pull Request

---

## 📄 License

MIT — use it freely.
