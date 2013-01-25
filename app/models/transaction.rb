class Transaction < ActiveRecord::Base
  belongs_to :order
  belongs_to :user

  attr_accessible :user_id, :transaction_type, :amount
  validates :transaction_type, :presence => true, :inclusion => { :in => %w( debit credit) }
  validates :amount, :presence => true, :numericality => {  :greater_than_or_equal_to => 0 }
  validates :user_id, :presence => true
end
