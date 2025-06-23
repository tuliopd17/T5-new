# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "🌱 Iniciando seeds..."

# Criar usuário administrador
admin = User.find_or_create_by!(email: "admin@biblioteca.com") do |user|
  user.name = "Administrador"
  user.password = "123456"
  user.password_confirmation = "123456"
  user.role = "admin"
end

# Criar perfil para o admin
admin.create_profile!(
  bio: "Administrador do sistema de biblioteca",
  phone: "(41) 99999-9999",
  address: "UFPR - Setor de Ciências Exatas"
) unless admin.profile

# Criar usuário comum
user = User.find_or_create_by!(email: "usuario@biblioteca.com") do |u|
  u.name = "Usuário Teste"
  u.password = "123456"
  u.password_confirmation = "123456"
  u.role = "user"
end

# Criar perfil para o usuário comum
user.create_profile!(
  bio: "Estudante de Programação Web",
  phone: "(41) 88888-8888",
  address: "Curitiba - PR"
) unless user.profile

puts "👥 Usuários criados: #{User.count}"

# Criar categorias
categories = [
  { name: "Ficção Científica", description: "Livros de ficção científica e fantasia" },
  { name: "Romance", description: "Romances clássicos e contemporâneos" },
  { name: "Tecnologia", description: "Livros sobre programação e tecnologia" },
  { name: "História", description: "Livros de história mundial e do Brasil" },
  { name: "Filosofia", description: "Obras filosóficas clássicas e modernas" }
]

categories.each do |cat_data|
  Category.find_or_create_by!(name: cat_data[:name]) do |category|
    category.description = cat_data[:description]
  end
end

puts "📚 Categorias criadas: #{Category.count}"

# Criar autores
authors = [
  { name: "Isaac Asimov", birth_date: "1920-01-02", nationality: "Americano", 
    biography: "Escritor e bioquímico americano, famoso por suas obras de ficção científica." },
  { name: "Machado de Assis", birth_date: "1839-06-21", nationality: "Brasileiro",
    biography: "Escritor brasileiro, considerado um dos maiores da literatura nacional." },
  { name: "Robert C. Martin", birth_date: "1952-12-05", nationality: "Americano",
    biography: "Engenheiro de software e autor, conhecido como Uncle Bob." },
  { name: "Virginia Woolf", birth_date: "1882-01-25", nationality: "Britânica",
    biography: "Escritora britânica modernista, pioneira do fluxo de consciência." },
  { name: "Yuval Noah Harari", birth_date: "1976-02-24", nationality: "Israelense",
    biography: "Historiador israelense, autor de Sapiens e outros bestsellers." }
]

authors.each do |author_data|
  Author.find_or_create_by!(name: author_data[:name]) do |author|
    author.birth_date = author_data[:birth_date]
    author.nationality = author_data[:nationality]
    author.biography = author_data[:biography]
  end
end

puts "✍️ Autores criados: #{Author.count}"

# Criar livros
books_data = [
  {
    title: "Fundação",
    isbn: "978-8576572004",
    publication_date: "1951-05-01",
    pages: 244,
    description: "Primeiro livro da série Fundação de Isaac Asimov.",
    category: "Ficção Científica",
    authors: ["Isaac Asimov"]
  },
  {
    title: "Dom Casmurro",
    isbn: "978-8594318602",
    publication_date: "1899-01-01",
    pages: 208,
    description: "Romance clássico da literatura brasileira.",
    category: "Romance",
    authors: ["Machado de Assis"]
  },
  {
    title: "Clean Code",
    isbn: "978-0132350884",
    publication_date: "2008-08-01",
    pages: 464,
    description: "Um manual de artesanato de software ágil.",
    category: "Tecnologia",
    authors: ["Robert C. Martin"]
  },
  {
    title: "Mrs. Dalloway",
    isbn: "978-0156628709",
    publication_date: "1925-05-14",
    pages: 194,
    description: "Romance modernista sobre um dia na vida de Clarissa Dalloway.",
    category: "Romance",
    authors: ["Virginia Woolf"]
  },
  {
    title: "Sapiens",
    isbn: "978-8525432681",
    publication_date: "2011-01-01",
    pages: 512,
    description: "Uma breve história da humanidade.",
    category: "História",
    authors: ["Yuval Noah Harari"]
  },
  {
    title: "I, Robot",
    isbn: "978-0553382563",
    publication_date: "1950-12-02",
    pages: 253,
    description: "Coletânea de contos sobre robôs e as três leis da robótica.",
    category: "Ficção Científica",
    authors: ["Isaac Asimov"]
  }
]

books_data.each do |book_data|
  next if Book.exists?(isbn: book_data[:isbn])
  
  category = Category.find_by(name: book_data[:category])
  
  book = Book.create!(
    title: book_data[:title],
    isbn: book_data[:isbn],
    publication_date: book_data[:publication_date],
    pages: book_data[:pages],
    description: book_data[:description],
    category: category
  )
  
  # Associar autores
  book_data[:authors].each do |author_name|
    author = Author.find_by(name: author_name)
    book.authors << author if author
  end
end

puts "📖 Livros criados: #{Book.count}"

# Criar alguns empréstimos
loan1 = Loan.find_or_create_by!(
  user: user,
  book: Book.find_by(title: "Clean Code")
) do |loan|
  loan.loan_date = 1.week.ago
  loan.return_date = 1.week.from_now
  loan.returned = false
  loan.status = "active"
end

puts "📋 Empréstimos criados: #{Loan.count}"

puts "✅ Seeds concluídas com sucesso!"
puts ""
puts "🔑 Credenciais de acesso:"
puts "Admin: admin@biblioteca.com / 123456"
puts "User: usuario@biblioteca.com / 123456"
