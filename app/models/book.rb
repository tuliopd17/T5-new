class Book < ApplicationRecord
  # Relação n:1 com Category
  belongs_to :category
  
  # Relação n:n com Author através de BookAuthor
  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors
  
  # Relação 1:n com Loan
  has_many :loans, dependent: :destroy
  has_many :borrowers, through: :loans, source: :user
  
  validates :title, presence: true
  validates :isbn, presence: true, uniqueness: true
  
  scope :available, -> { where.not(id: Loan.active.select(:book_id)) }
  
  def available?
    !loans.active.exists?
  end
end
