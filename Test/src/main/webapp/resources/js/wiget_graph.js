//원형 그래프 색깔변경 함수
function colpick() {
	$('#color-box-range').colpick({
		colorScheme : 'dark',
		layout : 'rgbhex',
		color : '#54BBE0',
		onSubmit : function(hsb, hex, rgb, el) {
			$(el).css('background-color', '#' + hex);
			setr = '#' + hex;
			$(el).colpickHide();
			$('.rs-range-color').css('background-color', setr);
			// change();
		}
	}).css('background-color', '#54BBE0');

	$('#color-box-path').colpick({
		colorScheme : 'dark',
		layout : 'rgbhex',
		color : '#d4d0d4',
		onSubmit : function(hsb, hex, rgb, el) {
			$(el).css('background-color', '#' + hex);
			setp = '#' + hex;
			$(el).colpickHide();
			$('.rs-path-color').css('background-color', setp);
			change();
		}
	}).css('background-color', '#d4d0d4');

	$('#color-box-handle').colpick({
		colorScheme : 'dark',
		layout : 'rgbhex',
		color : '#838383',
		onSubmit : function(hsb, hex, rgb, el) {
			$(el).css('background-color', '#' + hex);
			seth = '#' + hex;
			$(el).colpickHide();
			$('.rs-handle').css('background-color', seth);
			change();
		}
	}).css('background-color', '#838383');

	$('#color-box-background').colpick({
		colorScheme : 'dark',
		layout : 'rgbhex',
		color : '#d4d0d4',
		onSubmit : function(hsb, hex, rgb, el) {
			$(el).css('background-color', '#' + hex);
			setb = '#' + hex;
			$(el).colpickHide();
			$('.rs-bg-color').css('background-color', setb);
			change();
		}
	}).css('background-color', '#d4d0d4');

}

function change(type, id){
	shapeselect = $("#target option:selected").text();
	var g_id = "#"+id;
	if(type == 1){
		 $(g_id).roundSlider({
			sliderType : "min-range",
			width : 32,
			radius : 100,
			value : val,
			keyboardAction : false,
			mouseScrollAction : true,
			handleShape : shapeselect
		});
	 }
	
	else if(type == 2){
		$(g_id).roundSlider({
			radius: 80,
			width: 14,
			handleSize: "24,12",
			handleShape: "square",
			sliderType: "min-range",
			value: 40
		});
		$(g_id + " .rs-range-color").css('background-color', '#5673E7');
		$(g_id + " .rs-path-color").css('background-color', '#dedede');
		$(g_id + " .rs-handle").css('background-color', '#000000');
		$(g_id + " .rs-border").css('background-color', 'white');
	}
	
	else if(type == 3){
		$(g_id).roundSlider({
		    radius: 80,
		    width: 14,
		    handleSize: "+8",
		    handleShape: "dot",
		    sliderType: "min-range",
		    value: 40
		});
		$(g_id + " .rs-range-color").css('background-color', '#ff8d00');
		$(g_id + " .rs-handle:after").css('background-color', '#000000');
		$(g_id + " .rs-border").css('border-color', '#ff8d00');

	}
	
	else if(type == 4){
		$("#"+id).roundSlider({
		    radius: 80,
		    width: 8,
		    handleSize: "+16",
		    handleShape: "dot",
		    sliderType: "min-range",
		    value: 65
		});
		$(g_id + " .rs-range-color").css('background-color', '#33B5E5');
		$(g_id + " .rs-path-color").css('background-color', '#C2E9F7');
		$(g_id + " .rs-handle").css('background-color', '#C2E9F7');
		$(g_id + " .rs-handle").css('padding', '7px');
		$(g_id + " .rs-handle").css('border', '2px solid #C2E9F7');
		$(g_id + " .rs-handle.rs-focus").css('border-color', '#33B5E5');
		$(g_id + " .rs-handle:after").css('border-color', '#33B5E5');
		$(g_id + " .rs-handle:after").css('background-color', '#33B5E5');
		$(g_id + " .rs-border").css('border-color', 'transparent');
		
		
	}
	
	else if(type == 5){
		$(".slider").roundSlider({
		    radius: 80,
		    width: 22,
		    handleSize: "+0",
		    sliderType: "min-range",
		    value: 55
		});
	}
		
	$(".slider").on("change", function (e) {
		val = e.value;
	}); 
		
}