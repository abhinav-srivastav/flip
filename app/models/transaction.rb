class Transaction < ActiveRecord::Base
  belongs_to :order
  belongs_to :user

  attr_accessible :user_id, :transaction_type, :amount, :order_id, :transaction_id
  validates :transaction_type, :presence => true, :inclusion => { :in => %w( debit credit) }
  validates :amount, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :user_id, :presence => true
  validates :transaction_id, :presence => true, :uniqueness => true

  before_validation :generate_transaction_id
  before_create :update_user_wallet


  private
    def update_user_wallet
      if self.transaction_type == 'debit'
        user.wallet -= self.amount
      else
        user.wallet += self.amount
      end
      user.save
    end
    def generate_transaction_id
      self.transaction_id = 'TS'+user.username+(Time.current.to_s).gsub(/[- UTC:]/,'')+order.id.to_s
    end    
end
