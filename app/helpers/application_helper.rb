module ApplicationHelper
  def spinner_tag
    image_tag("spinner.gif", :id => "spinner_img", :alt => "Loding...", :style => "display : none")
  end
  
  def link_to_add_images(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |img|
      render(association.to_s.singularize + "_form", :f => img)
    end
    link_to_function(name, "add_images(this,\"#{association}\",\"#{escape_javascript(fields)}\")")
  end

  def available?(product)
    return false if product.varients.availables.empty?
    true
  end
end
