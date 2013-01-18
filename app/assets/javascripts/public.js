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
    
    //zoom effect 
    $(".thumb_image").addimagezoom({ 
		zoomrange: [3, 4],
		magnifiersize: [900,500]
	});

	$(".small_image").hover(function(e){
      $(".thumb_image").attr('src',$(this).attr('src').replace('/small/','/thumb/'))    
      $(".thumb_image").addimagezoom({ 
		zoomrange: [3, 4],
		magnifiersize: [900,500]
	});
	});




	$(".sort [type = checkbox] ").click(function(){
		sort_by = $(this).attr('value')
		$('div.product_div').each(function(){
			console.log($(this).attr(sort_by))
		});
	});

});