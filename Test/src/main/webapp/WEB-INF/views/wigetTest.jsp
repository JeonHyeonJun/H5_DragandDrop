<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>jQuery UI Draggable</title>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<style>
	.draggable { width: 90px; height: 90px; padding: 0.5em; float: left; margin: 0 10px 10px 0; }
	#wiget_div { width: 50%; height:300px; border:2px solid #ccc; padding: 10px; float: left; margin-right: 10px }
	.alldiv { width: 100%; height: 100%; border: 1px solid black; }
	.wiget { width: 100px; height: 300px; border: 1px solid black; float: left; }
</style>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
$( function() {
	//sortable(정렬)
	$('#wiget_div').sortable({
		revert: true,	//붙는형식? false면 바로 붙고 true면 끌어당겨지듯이 붙음. 안쓰면 false인듯
		stop: function () {
			$(this).append("<div class='wiget_icon1'>-----------<br><textarea>텍스트</textarea></div>");
		}
    });
	
	
	$( "#draggable3" ).draggable({ 
    	containment: "#containment-wrapper", 
    	scroll: false 
	}); 
	
	//draggable (드래그)
    $( '.wiget_icon1').draggable({
    	connectToSortable: "#wiget_div",
        helper: "clone"							//드래그할때 원래 있던거는 제자리에 있고 복사본을 만들어서 드래그
    });
	
    $( '.wiget_icon2').draggable({
    	connectToSortable: "#wiget_div",
        helper: "clone"							//드래그할때 원래 있던거는 제자리에 있고 복사본을 만들어서 드래그
    });
    
    $( '#wiget_div').droppable({
    	drop: function( event, ui ) {
    		alert($(this).html());
    	}
    });
    
    $('#btn').on('click', function() {
    	var str = $('#containment-wrapper').html();
		alert(str);
	});
} );

</script>
</head>
<body>
 
<div class="alldiv">
	<div id="wiget_div">
	  <!-- <div id="draggable3" class="draggable ui-widget-content">
	    <p>I'm contained within the box</p>
	  </div> -->
	</div>
	 <input type="button" value="확인" id="btn">
	<div class="wiget">
		<img src="resources/img/icon_textbox.png" class="wiget_icon1">
		<img src="resources/img/icon_table.png" class="wiget_icon2">
	</div>
</div>
 

 
</body>
</html>