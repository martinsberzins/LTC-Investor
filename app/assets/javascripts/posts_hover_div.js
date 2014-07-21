var ready;
ready = function(){
	$(".posts_index_hover_div").hide()
	$(".posts_index_div").hover(function(){ 
        $(".posts_index_hover_div").show("slide", { direction: "down" }, 1000);, 
        function(){
        $(".posts_index_hover_div").hide("slide", { direction: "down" }, 1000);;
        console.log("hover");
      	});
}	


$(document).ready(ready);
$(document).on('page:load', ready);


