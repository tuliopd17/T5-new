class User < ApplicationRecord
  has_secure_password
  
  # Relação 1:1 com Profile
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile
  
  # Relação 1:n com Loan
  has_many :loans, dependent: :destroy
  has_many :borrowed_books, through: :loans, source: :book
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :role, inclusion: { in: %w[admin user] }
  
  def admin?
    role == 'admin'
  end
  
  def user?
    role == 'user'
  end
end
