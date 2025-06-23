# Sistema de Biblioteca - Trabalho 5 Programação Web

Sistema de biblioteca desenvolvido em Ruby on Rails com CRUD completo e relações entre entidades.

## Relacionamentos Implementados

### 1:1 (Um para Um)

- **User ↔ Profile**: Cada usuário tem exatamente um perfil

```ruby
# app/models/user.rb
has_one :profile, dependent: :destroy

# app/models/profile.rb
belongs_to :user
```

### 1:N (Um para Muitos)

- **Category → Books**: Uma categoria tem vários livros

```ruby
# app/models/category.rb
has_many :books, dependent: :destroy

# app/models/book.rb
belongs_to :category
```

- **User → Loans**: Um usuário pode ter vários empréstimos

```ruby
# app/models/user.rb
has_many :loans, dependent: :destroy

# app/models/loan.rb
belongs_to :user
belongs_to :book
```

### N:N (Muitos para Muitos)

- **Book ↔ Author**: Livros podem ter vários autores através da tabela intermediária `book_authors`

```ruby
# app/models/book.rb
has_many :book_authors, dependent: :destroy
has_many :authors, through: :book_authors

# app/models/author.rb
has_many :book_authors, dependent: :destroy
has_many :books, through: :book_authors

# app/models/book_author.rb (tabela intermediária)
belongs_to :book
belongs_to :author
```

## Como Executar

### 1. Instalar Dependências

```bash
bundle install
```

### 2. Configurar Banco de Dados

```bash
rails db:create
rails db:migrate
rails db:seed
```

### 3. Executar Aplicação

```bash
rails server
```

## Credenciais de Teste

- **Admin**: admin@biblioteca.com / 123456
- **Usuário**: usuario@biblioteca.com / 123456

## Executar Testes

```bash
rake test
```
