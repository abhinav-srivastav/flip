$(document).ready(function() {	
  
  $("div.root_category [type = checkbox]").each(function(){
    if ($(this).is(':checked'))
      $('#'+$(this).attr('value')).removeClass('child_category');
  });   
  
  $("div.root_category [type = checkbox]").click(function(){ 
     root_category_id = $(this).attr('value')
     if( $(this).is(':checked') ) 
      $('#'+root_category_id).removeClass('child_category');
    else{
      $("#"+root_category_id+" [type = checkbox]").attr('checked',false);
      $('#'+root_category_id).addClass('child_category');	
    }
  });
});

function add_images(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g" )
  $(link).parent().before(content.replace(regexp, new_id));
}

