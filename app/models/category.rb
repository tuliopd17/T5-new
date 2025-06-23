class Category < ApplicationRecord
  # Relação 1:n com Book
  has_many :books, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
end
