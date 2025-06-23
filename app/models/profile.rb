class Profile < ApplicationRecord
  # Relação 1:1 com User
  belongs_to :user
  
  validates :user_id, uniqueness: true
end
