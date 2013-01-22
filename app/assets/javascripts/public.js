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
		zoomrange: [3],
		imagevertcenter : true,
		magnifiersize: [900,500]
	});

	$(".small_image").click(function(e){
      $(".thumb_image").attr('src',$(this).attr('src').replace('/small/','/thumb/'))    
      $(".thumb_image").addimagezoom({ 
		zoomrange: [3],
		imagevertcenter : true,
		magnifiersize: [900,500]
	  });
	});

    $(".varients div:first-child").addClass('active')
	show_price();
	$(".select_varient").click(function(){
	  $(this).addClass('active').siblings().removeClass('active')
	  show_price();
	});
    

});

function show_price() {
	var_id = $('.active').attr('id').split(' ')
	$("dd#"+var_id[0]).show().siblings('.price_label').hide()

}


function add_varient_to_cart(){
	varient = ($('.active').attr('id')).split(' ')
	params ={};
	params['id'] = varient[0]
	params['price'] = varient[1]
	console.log()
	$.ajax({
		beforeSend: function(){ $('input[type="button"][value="grab in trolley"]').hide();
		                        $("#spinner_img").show();
		                      },
		type: 'POST',
		data: params,
		url: '/orders/add_line_item_to_order',
		complete: function(){ $('input[type="button"][value="grab in trolley"]').show();
		                      $("#spinner_img").hide();
		                      alert('Product added to cart!');
		                    }
	});
}