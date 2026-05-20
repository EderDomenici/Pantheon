# Pantheon 🏛️

Pantheon é um framework de desenvolvimento orientado a agentes autônomos projetado especificamente para as ferramentas Claude Code e Codex. Ele estrutura a execução de projetos de desenvolvimento de software em ciclos determinísticos de especificação, planejamento, auditoria, execução e verificação de qualidade de código.

## 🏛️ A Divindade e Suas Responsabilidades

No Pantheon, cada agente assume o papel de uma divindade grega com atribuições muito específicas e limites estritos para garantir a eficiência de consumo de tokens, segurança e consistência:

*   **⚡ Zeus (Orquestrador):** Gerencia a transição de fases, valida as pré-condições de cada comando e aciona o agente adequado para a execução.
*   **🦉 Atena (Auditora e Juíza):** Avalia os planos de execução antes de iniciarem (Audit Mode) e julga os resultados dos testes e linters (Judge Mode), podendo aprovar ou rejeitar tarefas automaticamente baseado em 11 condições críticas.
*   **⚖️ Themis (Signatária):** Valida se o planejamento operacional (`PLAN.md`) cobre exatamente e sem desvios o escopo acordado na especificação (`SPEC.md`), assinando formalmente o contrato (`CONTRACT.md`).
*   **🔨 Hefesto (Builder):** Implementa o código do projeto sequencialmente, executa comandos locais de compilação/teste, gerencia correções automáticas (com limite de 3 tentativas pelo circuit breaker) e realiza commits estruturados no Git.
*   **✉️ Hermes (Mensageiro e Memória):** Gerencia os logs de progresso (`PROGRESS.md`) e notas de handoff (`HANDOFF.md`), garantindo que o contexto seja compactado e restaurado corretamente entre sessões.
*   **☀️ Apolo (Sensor):** Executa linters, testes e typechecks do projeto e gera relatórios de status estruturados e limpos para análise da Atena.

## 🚀 Quick Start (Início Rápido)

### Instalação

Para instalar o framework localmente no seu Claude Code ou Codex, execute o script de instalação apropriado para o seu sistema:

#### No Windows (PowerShell):
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
.\install.ps1
```

#### No Linux / macOS (Bash):
```bash
chmod +x install.sh
./install.sh
```

### Comandos de Ciclo de Vida

Os agentes respondem a comandos específicos digitados no terminal da ferramenta de IA:

*   `/pantheon:discuss` - Inicia a entrevista interativa com Zeus para criar o `SPEC.md`.
*   `/pantheon:plan` - Gera o plano de tarefas `PLAN.md` com base na especificação.
*   `/pantheon:audit` - Aciona Atena para analisar e aprovar o plano.
*   `/pantheon:sign` - Aciona Themis para validar o escopo e assinar o contrato.
*   `/pantheon:execute` - Aciona Hefesto para iniciar a implementação das tarefas.
*   `/pantheon:verify` - Roda sensores do Apolo e gera o veredito de Atena no `VERIFY-REPORT.md`.
*   `/pantheon:status` - Mostra o progresso atual das tarefas.
*   `/pantheon:resume` - Restaura o contexto e orienta onde o desenvolvimento parou.

---

Para saber mais sobre o fluxo operacional e diretrizes de desenvolvimento, consulte o [Guia de Execução](docs/GUIDE.md).
