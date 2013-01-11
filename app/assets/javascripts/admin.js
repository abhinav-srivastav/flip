$(document).ready(function() {
  // procedure to change qunatity of the product ordered
  // $('.change_quantity').click(function(e) {
  // 	e.preventDefault();
  // 	parent_div = $(this).parents('td');
  // 	current_quantity = $(this).siblings('span').text();
  // 	console.log(current_quantity);
  // 	$(parent_div).children('div').fadeOut();
  // 	new_div = $('<div />').addClass('input_quantity');
  // 	text_box = $("<input />").attr('type', 'text').addClass('input-mini').val(current_quantity);
  // 	button = $('<input />').attr('type','button')
  // 	new_div.append(text_box);
  // 	new_div.append(button);
  // 	parent_div.append(new_div)
  // });

  // procedure to edit existing details of the product
  $(".edit_attribute").click(function(e) {
    e.preventDefault();
    curr_detail = $(this).parents('td').siblings(".details").text();
    console.log($(this).parents('td').siblings(".details").text(''));   
    new_div = $('<div />');
    text_box = $("<textarea />").css('height',100).css('width', 300).val(curr_detail);
    button = $('<input />').attr('type','button').val("Submit").addClass("btn btn-mini");
    new_div.append(text_box);
    new_div.append(button);
    $(this).parents('td').siblings(".details").append(new_div)
    
  });








});

function add_images(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g" )
  $(link).parent().before(content.replace(regexp, new_id));
}

function add_product_attributes(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g" )
  $(link).parent().append(content.replace(regexp, new_id));
}

