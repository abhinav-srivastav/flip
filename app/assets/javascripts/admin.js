$(document).ready(function() {
  $('.change_quantity').click(function(e) {
  	e.preventDefault();
  	parent_div = $(this).parents('td');
  	current_quantity = $(this).siblings('span').text();
  	console.log(current_quantity);
  	$(parent_div).children('div').fadeOut();
  	new_div = $('<div />').addClass('input_quantity');
  	text_box = $("<input />").attr('type', 'text').addClass('input-mini').val(current_quantity);
  	button = $('<input />').attr('type','button')
  	new_div.append(text_box);
  	new_div.append(button);
  	parent_div.append(new_div)
  });
});

function add_images(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g" )
  console.log($(link))
  $(link).parent().before(content.replace(regexp, new_id));
}