var ready;
ready = function(){
	var span_text = $('#div_recomendation span').html();
	var color = "";
	var text = "";
	if (span_text == "Buy"){
		color = "#3DF24C";
		text = "B"
	} else if (span_text == "Sell"){
		color = "#F03E3E";
		text = "S"
	} else if (span_text == "Sell (too risky)"){
		color = "#F28B24";
		text = "S (TR)"
	} else if (span_text == "Hold)"){
		color = "#F2DA24";
		text = "H"
	}  else{
		color = "#F2DA24";
		text = "NA"
	}

	text = "<span>"+text+"</span>";
	
	var styles = {
		
		"height": "25px", 
	    "background" : color,
	    "text-align": "center",
	    "font-weight": "bolder",
	    "display": "table"
    };
	return $('#div_recomendation_color').css(styles).html(text);
}	


$(document).ready(ready);
$(document).on('page:load', ready);


