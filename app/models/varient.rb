class Varient < ActiveRecord::Base
  belongs_to :product
  belongs_to :colour
  belongs_to :size

  attr_accessible :mrp , :price, :available, :colour_id, :size_id, :product_id

  validates_presence_of :price, :available
  validates :colour_id, :uniqueness => { :scope => [:size_id , :product_id], :message => 'This combination already exist !' } 
  validates :size_id, :uniqueness => { :scope => [:colour_id, :product_id], :message => 'This combination already exist !' }
  # accepts_nested_attributes_for :colour
  scope :with_colour, joins(:colour, :size).select("colours.colour, group_concat(distinct sizes.size) as size").group('colours.colour')
  scope :with_size, joins(:size, :colour).select("sizes.size, group_concat(distinct colours.colour) as colour").group('sizes.size')






  def self.size_for_colour(col)
    joint_string = joins(:size, :colour).select('group_concat(distinct sizes.size) as size').group('colours.colour').having('colours.colour = ?', col).first
    joint_string['size'].split(',')
  end

  def self.colour_for_size(size)
    joint_string = joins(:colour, :size).select('group_concat(distinct colours.colour) as colour').group('sizes.size').having('sizes.size = ?', size).first
    joint_string['colour'].split(',')
  end
  

  def self.get_varient(product, var=nil)
    var ||= { 'colour' => product.varients.first.colour.colour   }
    pro_var = Hash.new { |hash, key| hash[key] = [] }
    pro_var[var.keys.first] << var[var.keys.first]
    if var.keys.first == 'colour'
      pro_var['size'] = product.varients.size_for_colour(var[var.keys.first])   
    else
      pro_var['colour']  = product.varients.colour_for_size(var[var.keys.first])   
    end
    pro_var
  end



end
