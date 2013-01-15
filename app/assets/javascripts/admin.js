$(document).ready(function() {	
  
  $("div.root_category [type = checkbox]").click(function(){ 
     category_id = $(this).attr('value')
     if( $(this).is(':checked') ) 
      $('#'+category_id).removeClass('child_category');
    else{
      console.log($("#"+category_id+" [type = checkbox]").attr('checked',false));
      $('#'+category_id).addClass('child_category');	
    }
  });
});

function add_images(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g" )
  $(link).parent().before(content.replace(regexp, new_id));
}

