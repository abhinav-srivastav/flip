module ApplicationHelper
  def spinner_tag
    image_tag("spinner.gif", :id => "spinner_img", :alt => "Loding...", :style => "display : none")
  end
end
