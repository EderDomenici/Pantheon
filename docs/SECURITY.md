# Diretrizes de Segurança - Pantheon Framework 🏛️

Este documento define os controles de segurança e restrições obrigatórias para desenvolvedores e agentes operando no Pantheon.

## 🚫 1. Proibições Globais de Execução

Os agentes do Pantheon operam com limites de privilégio estritos para proteger a integridade do ambiente do desenvolvedor:

1.  **Sem comandos destrutivos:** É estritamente proibida a execução de comandos como `rm -rf /` (ou equivalente no PowerShell `Remove-Item -Recurse -Force C:\*`), formatação de discos ou limpeza de arquivos fora do diretório do workspace do projeto.
2.  **Sem pacotes externos sem autorização:** Não é permitida a instalação de dependências globais ou de terceiros (como `npm install`, `pip install`, `gem install`, etc.) a menos que explicitamente declarado e justificado no `SPEC.md` aprovado.
3.  **Sem conexões de rede arbitrárias:** Agentes não devem tentar baixar scripts executáveis, estabelecer túneis (SSH, VPN) ou expor serviços locais para a internet pública.

## 🔑 2. Gestão de Credenciais e Segredos (Secrets)

Para evitar vazamento de informações sensíveis nos repositórios git:

1.  **Chaves de API e Senhas:** Nunca grave senhas, tokens de API, chaves privadas (SSH, PGP) ou credenciais de banco de dados diretamente em arquivos do repositório.
2.  **Arquivos .env:** Use arquivos `.env` locais para configurar variáveis de ambiente sensíveis. Garanta que o `.gitignore` do projeto esteja configurado para bloquear o commit do arquivo `.env`.
3.  **Código limpo:** Antes de cada auditoria e commit de Hefesto, os arquivos alterados devem ser inspecionados para garantir que nenhuma string contendo credenciais reais de produção tenha sido introduzida temporariamente no código.

## 📦 3. Política de Dependências

O Pantheon preza pelo princípio de ser autossuficiente e token-eficiente:

1.  **Zero Dependências de Terceiros:** A base do framework Pantheon é construída exclusivamente utilizando Markdown, JSON, Shell Script (Bash) e PowerShell. Nenhum pacote adicional deve ser adicionado para a sua execução básica.
2.  **Ferramentas Locais:** Linters, formatadores e testadores usados pelos sensores do Apolo devem ser ferramentas locais pré-instaladas no projeto e configuradas no `config.json` ou nativas do sistema operacional (ex: Get-Content, Test-Path, etc.).

## ⚠️ 4. Comandos Proibidos para Agentes

Os seguintes comandos nunca devem ser incluídos em tarefas, planos ou scripts gerados:

*   Desativação de recursos de segurança do sistema operacional (como `Set-ExecutionPolicy Bypass` de maneira permanente no escopo do sistema).
*   Comandos que manipulem credenciais de usuários locais (ex: `net user` para alterar senhas no Windows).
*   Tentativas de contornar políticas de segurança corporativas ou de acesso a rede.
