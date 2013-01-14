$(document).ready(function() {	
});

function add_images(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g" )
  $(link).parent().before(content.replace(regexp, new_id));
}

