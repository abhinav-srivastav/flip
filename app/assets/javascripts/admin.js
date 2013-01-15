$(document).ready(function() {	
  $("div.root_category [type = checkbox]").click(function(){ 
     if( $(this).is(':checked') ) 
      $('#'+$(this).attr('value')).removeClass('child_category');
    else
      $('#'+$(this).attr('value')).addClass('child_category');
  });
});

function add_images(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g" )
  $(link).parent().before(content.replace(regexp, new_id));
}

