class Author < ApplicationRecord
  # Relação n:n com Book através de BookAuthor
  has_many :book_authors, dependent: :destroy
  has_many :books, through: :book_authors
  
  validates :name, presence: true
end
