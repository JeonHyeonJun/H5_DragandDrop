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

}//colpick()

function change(type, id){
	var graph;
	var g_width, g_handleSize, g_handleShape, g_value;
	var g_type, rrc_bg, rpc_bg, rh_bg, rb_bg; 
	shapeselect = $("#target option:selected").text();
	var g_id = "#"+id;
	if(type == 1){
		graph = $(g_id).roundSlider({
			sliderType : "min-range",
			width : 32,
			radius : 80,
			value : val,
			handleShape : shapeselect,
			create : function (e) {
				graph = e.options;
				g_width = graph.width;
				g_radius = graph.radius;
				g_handleSize = graph.handleSize;
				g_handleShape = graph.handleShape;
				g_value = graph.value;
				g_type = 1;
				$('#g'+id).remove();
				$('#trash').prepend('<input type="hidden" id="g'+id+'" g_width="'+g_width+'" g_radius="'+g_radius+'" g_handleSize="'+g_handleSize+'" g_handleShape="'+g_handleShape+'" g_value="'+g_value+'" g_type="'+g_type+'">');
			},
			change : function(e) {
				graph = e.options;
				g_width = graph.width;
				g_radius = graph.radius;
				g_handleSize = graph.handleSize;
				g_handleShape = graph.handleShape;
				g_value = graph.value;
				g_type = 1;
				$('#g'+id).remove();
				$('#trash').prepend('<input type="hidden" id="g'+id+'" g_width="'+g_width+'" g_radius="'+g_radius+'" g_handleSize="'+g_handleSize+'" g_handleShape="'+g_handleShape+'" g_value="'+g_value+'" g_type="'+g_type+'">');
			}
		});
	 }
	
	else if(type == 2){
		graph = $(g_id).roundSlider({
			radius: 80,
			width: 14,
			handleSize: "24,12",
			handleShape: "square",
			sliderType: "min-range",
			value: 40,
			create : function (e) {
				$(g_id + " .rs-range-color").css('background-color', '#5673E7');
				$(g_id + " .rs-path-color").css('background-color', '#dedede');
				$(g_id + " .rs-handle").css('background-color', '#000000');
				$(g_id + " .rs-border").css('background-color', 'white');
				graph = e.options;
				g_width = graph.width;
				g_radius = graph.radius;
				g_handleSize = graph.handleSize;
				g_handleShape = graph.handleShape;
				g_value = graph.value;
				g_type = 2;
				rrc_bg = '#5673E7';
				rpc_bg = '#dedede';
				rh_bg = '#000000';
				rb_bg = 'white';
				$('#g'+id).remove();
				$('#trash').prepend('<input type="hidden" id="g'+id+'" g_width="'+g_width+'" g_radius="'+g_radius+'" g_handleSize="'+g_handleSize+'" g_handleShape="'+g_handleShape+'" g_value="'+g_value+'"'
						+' g_type="'+g_type+'" rrc_bg="'+rrc_bg+'" rpc_bg="'+rpc_bg+'" rh_bg="'+rh_bg+'" rb_bg="'+rb_bg+'">');
			},
			change : function(e) {
				graph = e.options;
				g_width = graph.width;
				g_radius = graph.radius;
				g_handleSize = graph.handleSize;
				g_handleShape = graph.handleShape;
				g_value = graph.value;
				g_type = 2;
				rrc_bg = $(g_id + " .rs-range-color").css('background-color');
				rpc_bg = $(g_id + " .rs-path-color").css('background-color');
				rh_bg = $(g_id + " .rs-handle").css('background-color');
				rb_bg = $(g_id + " .rs-border").css('background-color');
				
				$('#g'+id).remove();
				$('#trash').prepend('<input type="hidden" id="g'+id+'" g_width="'+g_width+'" g_radius="'+g_radius+'" g_handleSize="'+g_handleSize+'" g_handleShape="'+g_handleShape+'" g_value="'+g_value+'"'
									+' g_type="'+g_type+'" rrc_bg="'+rrc_bg+'" rpc_bg="'+rpc_bg+'" rh_bg="'+rh_bg+'" rb_bg="'+rb_bg+'">');
			}
		});
		
	}
	
	else if(type == 3){
		graph = $(g_id).roundSlider({
		    radius: 80,
		    width: 14,
		    handleSize: "+8",
		    handleShape: "dot",
		    sliderType: "min-range",
		    value: 40,
		    create : function (e) {
		    	$(g_id + " .rs-range-color").css('background-color', '#ff8d00');
				$(g_id + " .rs-handle").css('background-color', '#ffffff');
				$(g_id + " .rs-border").css('border-color', '#ff8d00');
				graph = e.options;
				g_width = graph.width;
				g_radius = graph.radius;
				g_handleSize = graph.handleSize;
				g_handleShape = graph.handleShape;
				g_value = graph.value;
				g_type = 3;
				rrc_bg = '#ff8d00';
				rh_bg = '#ffffff';
				rb_bd = '#ff8d00';
				$('#g'+id).remove();
				$('#trash').prepend('<input type="hidden" id="g'+id+'" g_width="'+g_width+'" g_radius="'+g_radius+'" g_handleSize="'+g_handleSize+'" g_handleShape="'+g_handleShape+'" g_value="'+g_value+'"'
								   +' g_type="'+g_type+'" rrc_bg="'+rrc_bg+'" rh_bg="'+rh_bg+'" rb_bd="'+rb_bd+'">');
			},
			change : function(e) {
				graph = e.options;
				g_width = graph.width;
				g_radius = graph.radius;
				g_handleSize = graph.handleSize;
				g_handleShape = graph.handleShape;
				g_value = graph.value;
				g_type = 3;
				rrc_bg = $(g_id + " .rs-range-color").css('background-color');
				rh_bg = $(g_id + " .rs-handle").css('background-color');
				rb_bd = $(g_id + " .rs-border").css('border-color');
				$('#g'+id).remove();
				$('#trash').prepend('<input type="hidden" id="g'+id+'" g_width="'+g_width+'" g_radius="'+g_radius+'" g_handleSize="'+g_handleSize+'" g_handleShape="'+g_handleShape+'" g_value="'+g_value+'"'
								   +' g_type="'+g_type+'" rrc_bg="'+rrc_bg+'" rh_bg="'+rh_bg+'" rb_bd="'+rb_bd+'">');
			}
		});

	}
	
	else if(type == 4){
		graph = $("#"+id).roundSlider({
		    radius: 80,
		    width: 8,
		    handleSize: "+16",
		    handleShape: "dot",
		    sliderType: "min-range",
		    value: 65,
		    create : function (e) {
				graph = e.options;
				g_width = graph.width;
				g_radius = graph.radius;
				g_handleSize = graph.handleSize;
				g_handleShape = graph.handleShape;
				g_value = graph.value;
				g_type = 4;
				rrc_bg = '#33B5E5';
				rpc_bg = '#C2E9F7';
				rh_bg = '#C2E9F7';
				rh_pd = '7px';
				rhrf_bd = '#33B5E5';
				rb_bd = 'transparent';
				$('#g'+id).remove();
				$('#trash').prepend('<input type="hidden" id="g'+id+'" g_width="'+g_width+'" g_radius="'+g_radius+'" g_handleSize="'+g_handleSize+'" g_handleShape="'+g_handleShape+'" g_value="'+g_value+'"'
						   +' g_type="'+g_type+'" rrc_bg="'+rrc_bg+'" rpc_bg="'+rpc_bg+'" rh_bg="'+rh_bg+'" rh_pd="'+rh_pd+'" rhrf_bd="'+rhrf_bd+'" rb_bd="'+rb_bd+'">');
			},
			change : function(e) {
				graph = e.options;
				g_width = graph.width;
				g_radius = graph.radius;
				g_handleSize = graph.handleSize;
				g_handleShape = graph.handleShape;
				g_value = graph.value;
				g_type = 4;
				rrc_bg = $(g_id + " .rs-range-color").css('background-color');
				rpc_bg = $(g_id + " .rs-path-color").css('background-color');
				rh_bg = $(g_id + " .rs-handle").css('background-color');
				rh_pd = $(g_id + " .rs-handle").css('padding');
				rhrf_bd = $(g_id + " .rs-handle.rs-focus").css('border-color');
				rb_bd = $(g_id + " .rs-border").css('border-color');
				$('#g'+id).remove();
				$('#trash').prepend('<input type="hidden" id="g'+id+'" g_width="'+g_width+'" g_radius="'+g_radius+'" g_handleSize="'+g_handleSize+'" g_handleShape="'+g_handleShape+'" g_value="'+g_value+'"'
						   +' g_type="'+g_type+'" rrc_bg="'+rrc_bg+'" rpc_bg="'+rpc_bg+'" rh_bg="'+rh_bg+'" rh_pd="'+rh_pd+'" rhrf_bd="'+rhrf_bd+'" rb_bd="'+rb_bd+'">');
			}
		});
		$(g_id + " .rs-range-color").css('background-color', '#33B5E5');
		$(g_id + " .rs-path-color").css('background-color', '#C2E9F7');
		$(g_id + " .rs-handle").css('background-color', '#C2E9F7');
		$(g_id + " .rs-handle").css('padding', '7px');
		$(g_id + " .rs-handle.rs-focus").css('border-color', '#33B5E5');
		$(g_id + " .rs-border").css('border-color', 'transparent');
		
		
	}
		
	$(".slider").on("change", function (e) {
		val = e.value;
	}); 
		
	
}

