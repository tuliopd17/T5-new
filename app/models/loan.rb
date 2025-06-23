class Loan < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  validates :loan_date, presence: true
  validates :status, inclusion: { in: %w[active returned overdue] }
  
  scope :active, -> { where(returned: false) }
  scope :returned, -> { where(returned: true) }
  scope :overdue, -> { where('return_date < ? AND returned = ?', Date.current, false) }
  
  before_save :set_default_values
  
  def overdue?
    return_date < Date.current && !returned?
  end
  
  def days_overdue
    return 0 unless overdue?
    (Date.current - return_date).to_i
  end
  
  private
  
  def set_default_values
    self.returned ||= false
    self.status ||= 'active'
    self.return_date ||= loan_date + 14.days if loan_date
  end
end
