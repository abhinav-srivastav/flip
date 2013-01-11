$(document).ready(function(){
	// add address to order
	$('.order_address div').click(function() {
		$(this).siblings().removeClass('selected')
		$(this).addClass('selected');
		order = {};
		params = {};
		order['id'] = $("div.order_address").attr('id')
		order['address_id'] = $("div.selected").attr('id');
		$("div.selected").siblings().children("a").show();
		params['order'] = order
		order_url = "/orders/"+order['id']
		$.ajax({
			beforeSend: function() { $("#spinner_img").show();},
			type: 'PUT',
			data: params,
			url: order_url,
			complete: function(){ $("#spinner_img").hide(); }
		});
	});
});