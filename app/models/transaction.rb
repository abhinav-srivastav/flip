class Transaction < ActiveRecord::Base
  belongs_to :order
  belongs_to :user

  attr_accessible :user_id, :transaction_type, :amount, :order_id, :transaction_id
  validates :transaction_type, :presence => true, :inclusion => { :in => %w( debit credit) }
  validates :amount, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :user_id, :presence => true
  validates :transaction_id, :presence => true, :uniqueness => true

  before_validation :generate_transaction_id, :on => :create
  before_create :update_user_wallet


  def debit?
    transaction_type == 'debit'
  end

  private
    def update_user_wallet
      user.wallet += debit? ? -(self.amount) : self.amount
      user.save
    end

    def generate_transaction_id
      self.transaction_id = "TS#{Time.current.to_i}" unless transaction_id?
    end    
end
