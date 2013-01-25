$(document).ready(function(){
	// add highlight selected address for order
	$('.order_address div').click(function() {
		$(this).siblings().removeClass('selected')
		$(this).addClass('selected');
	});
    $(".pay").click(function(){
    	address_id = $("div.order_address .selected").attr('id')
    	console.log(address_id)
    	$(this).siblings("#address").attr('value', address_id)
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
	if ($(".varients div:first-child").length) {
      show_price();
	}
	$(".select_varient").click(function(){
	  $(this).addClass('active').siblings().removeClass('active')
	  show_price();
	});

	$(".add_to_cart").click(function(){
	  varient = ($('.active').attr('id')).split(' ')
	  $(this).siblings('#id').attr('value', varient[0])
	  $(this).siblings('#price').attr('value', varient[1])	
	});
    

});

function show_price() {
	var_id = $('.active').attr('id').split(' ')
	$("dd#"+var_id[0]).show().siblings('.price_label').hide()

}