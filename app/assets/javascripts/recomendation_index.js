var ready = function(){
	$(".div_recomendation_color_index span").each(function(index){
		var color = "";
		span_text = $( this ).html();
		console.log(span_text)
		if (span_text == "B"){
			color = "#3DF24C";
		} else if (span_text == "S"){
			color = "#F03E3E";
		} else if (span_text == "S (TR)"){
			color = "#F28B24";
		} else {
			color = "#F2DA24";
		};

		var styles = {
			"height": "25px", 
		    "background" : color,
		    "text-align": "center",
		    "font-weight": "bolder",
		    "display": "table",
		    "margin-top": "48px"
	    };
		$(this).parent().css(styles);
		$(this).css({"display": "table-cell", "vertical-align": "middle"})
	});
}


$(document).ready(ready);
$(document).on('page:load', ready);