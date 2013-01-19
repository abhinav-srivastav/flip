$(document).ready(function() {	
  // for product form sub-category listing ---initial
  $("div.root_category [type = checkbox]").each(function(){
    if ($(this).is(':checked'))
      $('#'+$(this).attr('value')).removeClass('child_category');
  });   
  
  /* toggle show/hide sub-category when category checked/unchecked 
  with de-selection of any selected sub-category */
  $("div.root_category [type = checkbox]").click(function(){ 
     root_category_id = $(this).attr('value')
     if( $(this).is(':checked') ) 
      $('#'+root_category_id).removeClass('child_category');
    else{
      $("#"+root_category_id+" [type = checkbox]").attr('checked',false);
      $('#'+root_category_id).addClass('child_category');	
    }
  });

  // show/hide the remove prototype checkboxes
  $("#remove_prototype").click(function(){
    if($(this).is(':checked'))
      $(".remove_prototype").removeClass('hidden')
    else
      $(".remove_prototype").addClass('hidden')
  }); 

  // to hide all other pane except product details in product form
  $(".main_form:gt(0)").hide()
  // get only the selected tab visible in product form
  $('ul.product_nav a').click(function (e) {
    e.preventDefault();
    a = $(this).attr('href');
    $(a).siblings('.tab-pane').fadeOut().end().fadeIn();
  });
  $('#myTab a').click(function (e) {
  e.preventDefault();
  $(this).tab('show');
})
});

function add_images(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g" )
  $(link).parent().before(content.replace(regexp, new_id));
}


