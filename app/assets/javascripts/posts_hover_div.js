var ready;
ready = function(){
	$(".posts_index_hover_div").hide();
	$( ".posts_index_div")
  		.hover(function() {
    $(this).find(".posts_index_hover_div").stop().slideToggle();
  	});
	};	


$(document).ready(ready);
$(document).on('page:load', ready);


