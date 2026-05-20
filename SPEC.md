# SPEC

## Projeto
Pantheon — Framework de desenvolvimento com agentes para Claude Code e Codex.

## Repositório
`pantheon/` (local, será publicado como público sem licença permissiva)

## Stack
- Language: Markdown (skills, commands, templates, docs)
- Language: Bash (install.sh)
- Language: PowerShell (install.ps1)
- Runtime alvo: Claude Code (`~/.claude/commands/`), Codex (`~/.codex/skills/`)
- Nenhuma dependência externa. Zero npm, zero Python. Apenas arquivos `.md`, `.json` e scripts de instalação.

## Objetivo
Construir o framework Pantheon V0.1 (MVP) conforme definido em `PANTHEON-ARCHITECTURE.md`. O resultado final é um repositório pronto para uso imediato com Claude Code.

## Entregáveis V0.1

### 1. Skills dos Agentes
Cada agente tem um `SKILL.md` que define identidade, responsabilidades, permissões, proibições e formato de saída. Todos referenciam `GLOBAL_RULES.md` — nunca duplicam regras.

```
skills/
├── GLOBAL_RULES.md
├── zeus/SKILL.md
├── athena/SKILL.md
├── hephaestus/SKILL.md
├── hermes/SKILL.md
└── apollo/SKILL.md
```

**GLOBAL_RULES.md** contém:
- Matriz de permissões (tabela)
- Proibições globais de segurança
- Taxonomia de falhas
- Circuit breaker (regra dos 3 retries)
- Regras de Git (branch, commit, rollback)
- Princípio: todo contexto vem de `.md`, zero prompt inline

**Zeus SKILL.md** deve conter:
- Identidade: orquestrador
- Pode: ler `.pantheon/**`, identificar próxima etapa, acionar agente correto, validar pré-condições
- Não pode: executar código, alterar código-fonte, criar commits, fazer auditoria, ignorar rejeição de Atena
- Pré-condições por comando (ex: `/pantheon:execute` requer AUDIT.md com status APPROVED)
- Referencia GLOBAL_RULES.md

**Atena SKILL.md** deve conter:
- Identidade: auditora e juíza
- Dois modos: auditoria de plan (pré-execução) e julgamento de verify (pós-execução)
- 11 condições de auto-rejeição (conforme ARCHITECTURE.md)
- Severidades: BLOCKER, MAJOR, MINOR, INFO
- Regra: BLOCKER ou MAJOR = rejeição automática
- Formato de saída: AUDIT.md (quando auditando plan), seção de julgamento em VERIFY-REPORT.md (quando verificando)
- Referencia GLOBAL_RULES.md

**Hefesto SKILL.md** deve conter:
- Identidade: builder
- Lê: SPEC.md + PLAN.md (status APPROVED)
- Executa uma task por vez, em ordem de dependência
- Um commit por task, mensagem segue template do config.json
- Gera EXECUTION-SUMMARY.md após cada task
- Se sensor local falhar, tenta corrigir (max 3 tentativas — circuit breaker)
- Nunca altera arquivos fora da lista do PLAN.md sem registrar desvio
- Diferencia tasks de código e tasks de infra (ex: migration antes de código)
- Referencia GLOBAL_RULES.md

**Hermes SKILL.md** deve conter:
- Identidade: mensageiro e memória
- Gerencia PROGRESS.md e HANDOFF.md
- Registra: última task concluída, task atual, último commit, pendências, próximo comando
- Compactação: quando fase conclui, sumariza tasks em formato denso e move para "Histórico Compactado"
- No `/pantheon:resume`: restaura contexto lendo PROGRESS.md + HANDOFF.md, apresenta estado atual ao dev
- Referencia GLOBAL_RULES.md

**Apolo SKILL.md** deve conter:
- Identidade: sensor
- Executa apenas comandos definidos em `config.json` → seção `sensors`
- Formato de saída estruturado (typecheck, lint, tests, build — cada um com status, comando, erros)
- Trunca output verboso — extrai apenas resumo estruturado
- Nunca opina, nunca corrige, nunca sugere
- Entrega VERIFY-REPORT.md (seção de sensores) para Atena julgar
- Referencia GLOBAL_RULES.md

### 2. Comandos

Cada comando é um `.md` que o dev invoca via `/pantheon:COMANDO`. O comando define o que Zeus deve fazer ao ser acionado.

```
commands/
└── pantheon/
    ├── discuss.md
    ├── plan.md
    ├── audit.md
    ├── execute.md
    ├── verify.md
    ├── status.md
    └── resume.md
```

**discuss.md:**
- Zeus conduz conversa interativa com o dev
- Objetivo: gerar SPEC.md completo no formato do schema
- Deve perguntar sobre stack, padrões, convenções, sensores, regras de negócio
- Saída: `.pantheon/SPEC.md`

**plan.md:**
- Zeus lê SPEC.md
- Gera PLAN.md para a fase atual com tasks atômicas no formato do schema
- Cada task com: ID, tipo, dependências, arquivos esperados, critérios de aceite, comando de verificação, rollback, riscos
- Status do PLAN.md: PENDING_AUDIT
- Saída: `.pantheon/phases/XX/PLAN.md`

**audit.md:**
- Zeus aciona Atena
- Atena lê PLAN.md, aplica as 11 condições de auto-rejeição
- Gera AUDIT.md com veredito por task e veredito final
- Se APPROVED: status do PLAN.md muda para APPROVED
- Se REJECTED: AUDIT.md contém feedback com severidade por task
- Saída: `.pantheon/phases/XX/AUDIT.md`

**execute.md:**
- Zeus valida pré-condição: AUDIT.md existe e status = APPROVED
- Aciona Hefesto
- Hefesto executa tasks em ordem de dependência
- Um commit por task
- Gera EXECUTION-SUMMARY.md por task
- Circuit breaker: 3 falhas na mesma task → status ESCALATED
- Saída: código commitado + `.pantheon/phases/XX/EXECUTION-SUMMARY.md`

**verify.md:**
- Zeus aciona Apolo → depois Atena
- Apolo roda sensores do config.json, preenche seção de sensores do VERIFY-REPORT.md
- Atena lê resultado dos sensores, julga, preenche seção de julgamento
- Se PASS: Hermes atualiza PROGRESS.md
- Se FAIL: VERIFY-REPORT.md contém tipo de falha (taxonomia) + ação recomendada → volta para execute
- Saída: `.pantheon/phases/XX/VERIFY-REPORT.md` + `PROGRESS.md` atualizado

**status.md:**
- Zeus aciona Hermes
- Hermes lê PROGRESS.md e apresenta estado atual: fase, tasks, pendências, próximo comando
- Saída: output no terminal (não gera arquivo)

**resume.md:**
- Zeus aciona Hermes
- Hermes lê PROGRESS.md + HANDOFF.md
- Restaura contexto: onde parou, o que falta, decisões relevantes
- Apresenta ao dev o estado completo para continuar
- Saída: output no terminal com contexto restaurado

### 3. Templates (schemas)

Templates vazios que servem como referência de formato. Cada agente consulta o template ao gerar o artefato.

```
schemas/
├── SPEC.template.md
├── PLAN.template.md
├── AUDIT.template.md
├── EXECUTION-SUMMARY.template.md
├── VERIFY-REPORT.template.md
└── PROGRESS.template.md
```

Conteúdo de cada template: exatamente o schema definido na seção "Schemas dos Artefatos" do ARCHITECTURE.md, com placeholders `[...]` nos campos de valor.

### 4. Scripts de Instalação

**install.sh** (Linux/macOS):
- Detecta se Claude Code está instalado (`~/.claude/`)
- Detecta se Codex está instalado (`~/.codex/`)
- Copia `commands/pantheon/` para `~/.claude/commands/pantheon/`
- Copia `skills/` para `~/.claude/commands/pantheon-skills/` (Claude Code lê de commands)
- Se Codex: copia `skills/` para `~/.codex/skills/pantheon/`
- Valida instalação (checa se arquivos existem)
- Mensagem de sucesso ou erro

**install.ps1** (Windows):
- Mesma lógica, adaptada para PowerShell e paths Windows

### 5. Documentação

```
docs/
├── GUIDE.md
└── SECURITY.md
```

**GUIDE.md:**
- Como instalar
- Como usar cada comando
- Workflow completo com exemplo
- FAQ

**SECURITY.md:**
- Proibições globais
- Política de secrets
- Política de dependências
- Comandos proibidos

### 6. README.md
- Descrição do projeto
- Os deuses e suas responsabilidades
- Quick start
- Link para GUIDE.md

## Padrões de Código

### Naming
- Arquivos de skills: `SKILL.md` (uppercase)
- Arquivos de comando: `lowercase.md`
- Arquivos de template: `UPPERCASE.template.md`
- Pastas de agentes: inglês, lowercase (`zeus/`, `athena/`, `hephaestus/`, `hermes/`, `apollo/`)
- Pastas de fase: `XX-slug` (ex: `01-setup-base`)

### Markdown
- Headers com `#`, não underline
- Tabelas alinhadas
- Code blocks com linguagem especificada
- Sem emojis nos arquivos técnicos (skills, commands, schemas)
- README.md pode ter emojis moderados

### Linguagem
- Skills e commands: inglês (é o que os runtimes interpretam melhor)
- Docs e README: português (público alvo inicial: dev brasileiro)
- Comentários em scripts: inglês

## Princípios Inegociáveis

1. **Token-eficiente.** Cada skill e comando carrega o mínimo necessário. Nada de contexto redundante.
2. **Autocontido.** Cada `.md` faz sentido sozinho. Agente lê o arquivo e sabe o que fazer sem depender de prompt anterior.
3. **Determinístico.** Mesmo input → mesmo output. Skills não deixam margem para interpretação criativa.
4. **Sem dependência externa.** Zero npm install para usar o framework. Apenas Markdown, JSON e shell scripts.
5. **Feedback > Feed Forward.** Os sensores (Apolo) são mais importantes que as instruções. Se o sensor diz FAIL, não importa o que o prompt diz.

## Fora de Escopo (V0.1)

- CLI própria
- Modos prototype/normal/critical
- Changelog automático
- Métricas
- Suporte a stacks além de Node/TypeScript
- Contexto global entre projetos
- `/pantheon:fast`
- Doctor/diagnóstico
