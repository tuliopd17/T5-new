# 📤 Guia de Upload para GitHub

## 🚀 Passo a Passo para Subir no GitHub

### 1. Criar Repositório no GitHub

1. Acesse https://github.com
2. Clique em "New repository" ou "+"
3. Configure:
   - **Repository name**: `sistema-biblioteca` (ou nome de sua preferência)
   - **Description**: `Sistema de Biblioteca Digital - Trabalho 5 Programação Web UFPR`
   - **Visibility**: Public (ou Private se preferir)
   - ✅ **Add a README file**: DESMARQUE (já temos um README)
   - ✅ **Add .gitignore**: DESMARQUE (já temos um .gitignore)
   - ✅ **Choose a license**: Pode selecionar MIT ou deixar em branco
4. Clique em "Create repository"

### 2. Comandos para Upload

No terminal, execute os comandos na sequência:

```bash
# 1. Inicializar repositório Git (se ainda não foi feito)
git init

# 2. Adicionar arquivos (respeitando .gitignore)
git add .

# 3. Fazer o primeiro commit
git commit -m "feat: sistema completo de biblioteca com CRUD, autenticação e testes

- Implementado CRUD completo para livros, autores, categorias e usuários
- Sistema de autenticação com roles (admin/user)
- Relacionamentos 1:1, 1:n e n:n entre modelos
- Interface responsiva com Bootstrap 5 e JavaScript
- Sistema de empréstimos de livros
- Suite completa de testes (38 testes passando)
- Validações frontend e backend
- Documentação completa"

# 4. Adicionar remote do GitHub (SUBSTITUA pela sua URL)
git remote add origin https://github.com/SEU_USUARIO/sistema-biblioteca.git

# 5. Fazer o push
git branch -M main
git push -u origin main
```

### 3. Verificar se o Upload foi Correto

Após o push, verifique no GitHub se:

- ✅ Todos os arquivos importantes estão presentes
- ✅ README.md está sendo exibido na página principal
- ✅ Arquivos sensíveis NÃO estão presentes:
  - ❌ `db/development.sqlite3`
  - ❌ `db/test.sqlite3`
  - ❌ `log/development.log`
  - ❌ `config/master.key`
  - ❌ `tmp/` directory contents

### 4. Configurar Repository Settings (Opcional)

No GitHub, vá em Settings do repositório:

1. **General**:

   - Adicione topics/tags: `rails`, `ruby`, `biblioteca`, `crud`, `bootstrap`
   - Configure descrição detalhada

2. **Pages** (para deploy gratuito):

   - Se quiser hospedar gratuitamente, configure GitHub Pages
   - Mas para Rails, recomenda-se Heroku ou Railway

3. **Security**:
   - Configure branch protection se necessário
   - Adicione colaboradores se for trabalho em grupo

### 5. README Personalizado

Personalize o README.md substituindo:

- `[Seu Nome]` pelo seu nome real
- Links e informações específicas do seu projeto
- Adicione screenshots se desejar

### 6. Comandos para Atualizações Futuras

```bash
# Para adicionar mudanças futuras
git add .
git commit -m "fix: descrição da mudança"
git push

# Para sincronizar com mudanças remotas
git pull origin main

# Para ver histórico
git log --oneline
```

## 📸 Adicionando Screenshots (Opcional)

Para deixar o README mais atrativo:

1. Tire screenshots da aplicação:

   - Tela de login
   - Lista de livros
   - Formulário de cadastro
   - Interface admin

2. Crie uma pasta `docs/screenshots/`

3. Adicione as imagens ao README:

```markdown
## 📱 Screenshots

### Tela de Login

![Login](docs/screenshots/login.png)

### Lista de Livros

![Livros](docs/screenshots/books.png)
```

## 🏷️ Tags e Releases

Para marcar versões:

```bash
# Criar tag para versão
git tag -a v1.0.0 -m "Versão 1.0.0 - Sistema completo"
git push origin v1.0.0
```

No GitHub, vá em "Releases" e crie uma release oficial.

## 🤝 Colaboração (se for trabalho em grupo)

1. Adicione colaboradores em Settings > Manage access
2. Configure branch protection
3. Use Pull Requests para mudanças
4. Defina padrão de commits e branches

## 🔗 Links Úteis

- **Markdown Guide**: https://guides.github.com/features/mastering-markdown/
- **GitHub Pages**: https://pages.github.com/
- **Git Cheatsheet**: https://education.github.com/git-cheat-sheet-education.pdf

## ⚠️ Antes de Fazer o Push Final

Execute este checklist:

- [ ] Testei o sistema completamente
- [ ] Todos os testes estão passando (`rails test`)
- [ ] README está atualizado e correto
- [ ] .gitignore está configurado adequadamente
- [ ] Não há credenciais ou dados sensíveis no código
- [ ] Projeto funciona em uma instalação limpa
- [ ] Documentação está completa

---

Após seguir este guia, seu projeto estará profissionalmente disponível no GitHub! 🚀
