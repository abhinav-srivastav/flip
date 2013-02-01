$(document).ready(function(){
  if(window.location.pathname == '/') { 
    $('ul.category_catalog .root').show();
    $('div.other_attractions').css('margin-top', $('ul.category_catalog').height())
  }

  $('.write_review , .rate_product').click(function(e){
    e.preventDefault();
    if($(this).attr('data-valid') == 'true') {
      inputs = $(this).siblings('.input_form').find('.add_review_or_rating')
      $(inputs).siblings().each(function(){
      if($(this).css('display') != 'none')
        $(this).val('')  
       });
      $(this).siblings('.input_form').css('display', 'inline-block');
    }
    else
      window.location.href = '/LogIn'
  });

  $('.add_review_or_rating, .cancel_review_or_rating').click(function(){
    $(this).parents('.input_form').hide()
  });

	// add highlight selected address for order
	$('.order_address div').click(function() {
		$(this).siblings().removeClass('selected')
		$(this).addClass('selected');
	});

  $(".pay").click(function(){
   	address_id = $("div.order_address .selected").attr('id')
   	$(this).siblings("#address").attr('value', address_id)
  });

    //zoom effect 
    $(".thumb_image").addimagezoom({ 
		zoomrange: [3],
		imagevertcenter : true,
		magnifiersize: [600,200]
	});

	$(".small_image").click(function(e){
    $('div.zoomtracker').remove();
    d = $('<img />').attr('src', $(this).attr('src').replace('/tiny/','/thumb/')).addClass('thumb_image') 
    $(".thumb_image").parent().html(d)
    $(".thumb_image").addimagezoom({ 
		zoomrange: [3],
		imagevertcenter : true,
		magnifiersize: [600,200]
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
	  varient = ($('div.active').attr('id')).split(' ')
	  $(this).siblings('#id').attr('value', varient[0])
	  $(this).siblings('#price').attr('value', varient[1])	
	});
  
  $('.small_images img:lt(3)').addClass('active');

  // check if product has more than 3 images for image slider   
  if ($('.small_images img').length <= 3) {
    $('.image_show').detach()
  }
  else {
    $('.image_show').click(function(){
      if ($(this).attr('id') == 'right') {
      	if ($('.small_images img.active').last().next().length) {
          images = $('.small_images img.active')
          images.first().removeClass('active');
          images.last().next().addClass('active')
        }
      }
      else{
        if ($('.small_images img.active').first().prev().length) {
          images = $('.small_images img.active')
          images.last().removeClass('active');
          images.first().prev().addClass('active')  
        }
      }
    });
  }
  // using masonry js for image alignment
  var $container = $('div.category_products');
  $container.imagesLoaded(function(){
    $container.masonry({
      itemSelector : 'div.product_div',
      columnWidth : 180
    }); 
  });
});

function show_price() {
	var_id = $('div.active').attr('id').split(' ')
	$("div#"+var_id[0]).show().siblings('.price_label').hide()
}