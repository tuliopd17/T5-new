# 🚀 Guia de Deploy e Comandos Úteis

## 📤 Preparando para o GitHub

### 1. Verificar arquivos que serão commitados

```bash
# Ver status dos arquivos
git status

# Ver diferenças
git diff

# Ver arquivos ignorados (para verificar se o .gitignore está funcionando)
git status --ignored
```

### 2. Primeiro commit

```bash
# Inicializar repositório (se ainda não foi feito)
git init

# Adicionar todos os arquivos (respeitando o .gitignore)
git add .

# Fazer o primeiro commit
git commit -m "feat: sistema completo de biblioteca com CRUD, autenticação e testes"

# Adicionar remote do GitHub (substitua pela sua URL)
git remote add origin https://github.com/SEU_USUARIO/sistema-biblioteca.git

# Push inicial
git push -u origin main
```

## 🔧 Comandos de Desenvolvimento

### Banco de Dados

```bash
# Resetar banco completamente
rails db:drop db:create db:migrate db:seed

# Apenas rodar migrations pendentes
rails db:migrate

# Apenas popular com dados
rails db:seed

# Fazer backup do banco
cp db/development.sqlite3 db/backup_$(date +%Y%m%d_%H%M%S).sqlite3

# Ver status das migrations
rails db:migrate:status
```

### Testes

```bash
# Rodar todos os testes
rails test

# Testes com verbosidade
rails test -v

# Testes específicos por tipo
rails test test/models/
rails test test/controllers/
rails test test/integration/

# Teste específico
rails test test/models/user_test.rb

# Teste com seed específico para reproduzir erros
rails test --seed 12345
```

### Console e Debug

```bash
# Abrir console Rails
rails console
# ou
rails c

# Console com environment específico
rails console production
rails console test

# Ver rotas
rails routes

# Ver rotas de um controller específico
rails routes -c books

# Ver middlewares
rails middleware
```

### Assets e Cache

```bash
# Limpar cache de desenvolvimento
rails dev:cache

# Precompilar assets para produção
rails assets:precompile

# Limpar assets precompilados
rails assets:clean

# Verificar integridade dos assets
rails assets:verify
```

### Logs

```bash
# Ver logs em tempo real
tail -f log/development.log

# Ver apenas erros
tail -f log/development.log | grep ERROR

# Limpar logs
> log/development.log

# Ver logs de teste
tail -f log/test.log
```

## 🌐 Deploy em Produção

### Heroku (Exemplo)

```bash
# Instalar Heroku CLI primeiro
# https://devcenter.heroku.com/articles/heroku-cli

# Login no Heroku
heroku login

# Criar app
heroku create seu-app-biblioteca

# Configurar banco PostgreSQL
heroku addons:create heroku-postgresql:hobby-dev

# Configurar variáveis de ambiente
heroku config:set RAILS_MASTER_KEY=$(cat config/master.key)

# Deploy
git push heroku main

# Rodar migrations
heroku run rails db:migrate

# Popular banco (opcional)
heroku run rails db:seed

# Ver logs
heroku logs --tail

# Abrir app
heroku open
```

### Servidor Linux (VPS)

```bash
# No servidor
sudo apt update
sudo apt install ruby ruby-dev build-essential libsqlite3-dev nodejs npm

# Instalar Rails
gem install rails

# Clone do projeto
git clone https://github.com/seu-usuario/sistema-biblioteca.git
cd sistema-biblioteca

# Instalar dependências
bundle install --deployment --without development test

# Configurar banco
RAILS_ENV=production rails db:create db:migrate db:seed

# Precompilar assets
RAILS_ENV=production rails assets:precompile

# Iniciar servidor
RAILS_ENV=production rails server -p 80
```

## 🔄 Workflow de Desenvolvimento

### Branches

```bash
# Criar branch para nova feature
git checkout -b feature/nova-funcionalidade

# Fazer alterações e commits
git add .
git commit -m "feat: adicionar nova funcionalidade"

# Voltar para main e fazer merge
git checkout main
git merge feature/nova-funcionalidade

# Deletar branch após merge
git branch -d feature/nova-funcionalidade
```

### Commits Semânticos

```bash
# Exemplos de commits bem estruturados
git commit -m "feat: adicionar sistema de notificações"
git commit -m "fix: corrigir bug na validação de empréstimos"
git commit -m "docs: atualizar README com instruções de deploy"
git commit -m "style: melhorar layout da página de livros"
git commit -m "test: adicionar testes para modelo Book"
git commit -m "refactor: reorganizar structure dos controllers"
```

## 🛠️ Manutenção

### Atualizações

```bash
# Atualizar gems
bundle update

# Verificar vulnerabilidades
bundle audit

# Verificar gems desatualizadas
bundle outdated

# Atualizar Rails (cuidado!)
bundle update rails

# Verificar se tudo funciona após updates
rails test
```

### Monitoramento

```bash
# Ver tamanho do banco
ls -lh db/development.sqlite3

# Ver espaço usado pelos logs
du -h log/

# Verificar performance (com gem rack-mini-profiler)
# Adicionar ao Gemfile: gem 'rack-mini-profiler'
bundle install
# Acessar ?pp=help na URL
```

## 🔒 Segurança

### Checklist antes do deploy

- [ ] Todas as credenciais estão em variáveis de ambiente
- [ ] Master key não está no repositório
- [ ] Banco de dados de desenvolvimento não está no Git
- [ ] Logs não contêm informações sensíveis
- [ ] HTTPS está configurado em produção
- [ ] CORS está configurado adequadamente
- [ ] Rate limiting está ativo (se necessário)

### Comandos de segurança

```bash
# Verificar configurações de segurança
rails security:check

# Gerar nova master key (CUIDADO!)
# rails credentials:edit --environment production

# Verificar se há secrets expostos
git log --oneline | head -20
```

## 📊 Métricas e Debug

### Performance

```bash
# Benchmark de rotas específicas
rails runner "require 'benchmark'; puts Benchmark.measure { 100.times { Book.all.to_a } }"

# Ver queries SQL em tempo real
# No console Rails:
ActiveRecord::Base.logger = Logger.new(STDOUT)
```

### Debugging

```bash
# Usar byebug para debug
# Adicionar 'byebug' no código e rodar
rails server

# Debug de testes
rails test test/models/user_test.rb -v --backtrace
```

Este guia cobre os principais cenários de desenvolvimento e deploy. Adapte conforme necessário para seu ambiente específico!
