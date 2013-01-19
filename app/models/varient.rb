class Varient < ActiveRecord::Base
  belongs_to :product
  belongs_to :colour
  belongs_to :size

  attr_accessible :mrp , :price, :available, :colour_id, :size_id, :product_id

  validates_presence_of :price, :available
  validates :colour_id, :uniqueness => { :scope => [:size_id , :product_id], :message => 'This combination already exist !' } 
  validates :size_id, :uniqueness => { :scope => [:colour_id, :product_id], :message => 'This combination already exist !' }
  # accepts_nested_attributes_for :colour
  scope :with_colour, select("group_concat(distinct size_id)").group('colour_id')
  scope :with_size, select("group_concat(distinct colour_id)").group('size_id')

end
