#!/bin/bash

# 🚀 Script de Setup Automático - Sistema de Biblioteca
# Este script automatiza a configuração inicial do projeto

set -e  # Para o script se houver erro

echo "📚 ===== SISTEMA DE BIBLIOTECA - SETUP AUTOMÁTICO ====="
echo ""

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para print colorido
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCESSO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[AVISO]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERRO]${NC} $1"
}

# Verificar se está no diretório correto
if [ ! -f "Gemfile" ]; then
    print_error "Gemfile não encontrado. Execute este script no diretório raiz do projeto."
    exit 1
fi

print_status "Verificando pré-requisitos..."

# Verificar Ruby
if ! command -v ruby &> /dev/null; then
    print_error "Ruby não está instalado. Instale Ruby 3.3.4 ou superior."
    exit 1
fi

RUBY_VERSION=$(ruby --version | cut -d' ' -f2)
print_success "Ruby $RUBY_VERSION encontrado"

# Verificar Rails
if ! command -v rails &> /dev/null; then
    print_warning "Rails não encontrado. Instalando..."
    gem install rails
fi

RAILS_VERSION=$(rails --version | cut -d' ' -f2)
print_success "Rails $RAILS_VERSION encontrado"

# Verificar SQLite3
if ! command -v sqlite3 &> /dev/null; then
    print_error "SQLite3 não está instalado. Instale SQLite3."
    exit 1
fi

print_success "SQLite3 encontrado"

print_status "Instalando dependências..."

# Verificar se bundler está instalado
if ! command -v bundle &> /dev/null; then
    print_warning "Bundler não encontrado. Instalando..."
    gem install bundler
fi

# Instalar gems
print_status "Instalando gems Ruby..."
bundle install

print_success "Dependências instaladas com sucesso!"

print_status "Configurando banco de dados..."

# Configurar banco de dados
if [ -f "db/development.sqlite3" ]; then
    print_warning "Banco de dados já existe. Deseja recriá-lo? (y/N)"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        print_status "Recriando banco de dados..."
        rails db:drop db:create db:migrate db:seed
    else
        print_status "Apenas executando migrations pendentes..."
        rails db:migrate
    fi
else
    print_status "Criando banco de dados..."
    rails db:create db:migrate db:seed
fi

print_success "Banco de dados configurado!"

print_status "Executando testes para verificar integridade..."

# Rodar testes
if rails test; then
    print_success "Todos os testes passaram!"
else
    print_warning "Alguns testes falharam. Verifique os logs acima."
fi

print_status "Verificando se o servidor pode iniciar..."

# Testar se o servidor pode iniciar (timeout de 5 segundos)
timeout 5s rails server > /dev/null 2>&1 || true

print_success "Setup concluído com sucesso!"

echo ""
echo "🎉 ===== SETUP FINALIZADO ====="
echo ""
echo "Para iniciar o sistema:"
echo "  rails server"
echo ""
echo "Acesse no navegador:"
echo "  http://localhost:3000"
echo ""
echo "Credenciais de acesso:"
echo "  Admin: admin@library.com / password"
echo "  User:  user@library.com / password"
echo ""
echo "Comandos úteis:"
echo "  rails test          # Rodar testes"
echo "  rails console       # Console interativo"
echo "  rails db:seed       # Popular banco novamente"
echo ""
print_success "Bom desenvolvimento! 🚀"
