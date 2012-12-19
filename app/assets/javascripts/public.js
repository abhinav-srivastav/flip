$(document).ready(function(){
  $('.remove_line_item').click(function(){
    
    tr = $(this).parents('tr');
    console.log($(tr).attr('id'));
    url_del = "line_items/"+$(tr).attr('id');
    $(tr).fadeOut();
    $.ajax({
      type: 'DELETE',
      data: {_method:'delete'},
      url: url_del,
      success: function(){console.log("sdvkyugfuv")}
    });
  });

});