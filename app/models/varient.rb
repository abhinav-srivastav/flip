class Varient < ActiveRecord::Base
  belongs_to :product
  belongs_to :colour
  belongs_to :size
  has_many :line_items, :dependent => :destroy

  attr_accessible :mrp , :price, :available, :colour_id, :size_id, :product_id

  validates_presence_of :price
  validates :available, :numericality => { :greater_than => -1 }
  validates :colour_id, :uniqueness => { :scope => [:size_id , :product_id], :message => 'This combination already exist !' } 
  validates :size_id, :uniqueness => { :scope => [:colour_id, :product_id], :message => 'This combination already exist !' }

  scope :availables , where('available > 0')
end