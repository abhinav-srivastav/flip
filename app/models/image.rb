class Image < ActiveRecord::Base
  belongs_to :product
	attr_accessible :image
  has_attached_file :image, :styles => { :thumb => "200x200>", :small => "70x70>"},
          	    					  :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
 	  			           			  :url => "/system/:attachment/:id/:style/:filename"
 	# validates_attachment_presence :image
 	
end
