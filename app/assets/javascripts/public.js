$(document).ready(function(){
	
	$('.order_address div').click(function() {
		$(this).siblings().removeClass('selected')
		$(this).addClass('selected');
	});

	$('#save_address').click(function(e){
		e.preventDefault();
		order = {};
		params = {};
		order['id'] = $("div.order_address").attr('id')
		order['address_id'] = $("div.selected").attr('id');
		params['order'] = order
		order_url = "/orders/"+order['id']
		console.log(params)
		// console.log(order_url)
		$.ajax({
			beforeSend: function() { $("#save_address").hide(); $("#spinner_img").show();  },
			type: 'PUT',
			data: params,
			url: order_url,
			complete: function(){ $("#spinner_img").hide(); $("#save_address").show(); }
		});
	});

//   $('.remove_line_item').click(function(){
    
//     tr = $(this).parents('tr');
//     console.log($(tr).attr('id'));
//     url_del = "line_items/"+$(tr).attr('id');
//     $(tr).fadeOut();
//     $.ajax({
//       type: 'DELETE',
//       data: {_method:'delete'},
//       url: url_del,
//       success: function(){console.log("sdvkyugfuv")}
//     });
//   });

});