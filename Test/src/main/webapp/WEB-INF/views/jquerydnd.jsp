<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>jQuery UI Droppable - Simple photo manager</title>
  
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<link rel="stylesheet" type="text/css" href="resources/dataTables/DataTables-1.10.16/css/dataTables.jqueryui.css"/>
<link rel="stylesheet" type="text/css" href="resources/dataTables/ColReorder-1.4.1/css/colReorder.jqueryui.css"/>
<link rel="stylesheet" type="text/css" href="resources/dataTables/RowReorder-1.2.3/css/rowReorder.jqueryui.css"/>
<link rel="stylesheet" type="text/css" href="resources/dataTables/Select-1.2.5/css/select.jqueryui.css"/>

<script type="text/javascript" src="resources/dataTables/DataTables-1.10.16/js/jquery.dataTables.js"></script>
<script type="text/javascript" src="resources/dataTables/DataTables-1.10.16/js/dataTables.jqueryui.js"></script>
<script type="text/javascript" src="resources/dataTables/ColReorder-1.4.1/js/dataTables.colReorder.js"></script>
<script type="text/javascript" src="resources/dataTables/RowReorder-1.2.3/js/dataTables.rowReorder.js"></script>
<script type="text/javascript" src="resources/dataTables/Select-1.2.5/js/dataTables.select.js"></script>




  <style>
  #wigetBox { float: left; width: 65%; min-height: 12em; }
  .wigetBox.custom-state-active { background: #eee; }
  .wigetBox li { float: left; width: 96px; padding: 0.4em; margin: 0 0.4em 0.4em 0; text-align: center; }
  .wigetBox li h5 { margin: 0 0 0.4em; cursor: move; }
  .wigetBox li a { float: right; }
  .wigetBox li a.ui-icon-zoomin { float: left; }
  .wigetBox li img { width: 100%; height: 100%; cursor: move; }
 
  #trash { float: left; width: 32%; min-height: 18em; padding: 1%; }
  #trash h4 { line-height: 16px; margin: 0 0 0.4em; }
  #trash h4 .ui-icon { float: left; }
  #trash .wigetBox h5 { display: none; }
  
  .sidebox { background-color:#F0F0F0; position:absolute; width:120px; top:100px; right:300px; padding: 3px 10px }
	.textEditBox {
		background-color:#CCFFFF; 
		width:390px; 
		padding: 10px;
		position:absolute;
		top: 0px;
	}
	.textEditIcon {
		width: 20px;
		height: 20px;
		border: solid 1px black;
		cursor: pointer;
	}
  .wrap {
      width: 100%;
      height: 100%;
    }
    
    .img {
    	width: 100%;
    	height: 100%;
    }
    .addfile {
    	cursor: pointer;
    }
  
  </style>

<script>
document.execCommand('styleWithCSS', false, true);

document.execCommand('insertBrOnReturn', false, true);

$( function() {
	
	var valueNum = 4;	//임의의 파일(이미지,동영상)추가에 줄 값
	
	var currentPosition = parseInt($("#sidebox").css("top")); 
	$(window).scroll(function() { 
		var position = $(window).scrollTop(); 
	  	$("#sidebox").stop().animate({
	  		"top":position+currentPosition+"px"
	  		},500);
	  	$("#textEditBox").stop().animate({
	  		"top":position-100+currentPosition+"px"
	  		},500); 
	  	});
	  
	$('button').click(function(){
		document.execCommand($(this).attr('id'), false, true);
	});
	$('#bold').click(function() {
		document.execCommand('bold', false, true);
	});
	$('#selectAll').click(function() {
		document.execCommand('selectAll', false, true);
	});
	$('#italic').click(function() {
		document.execCommand('italic', false, true);
	});
	$("#underLine").click(function() {
		document.execCommand('underLine', false, true);
	});
	$("#justifyLeft").click(function() {
		document.execCommand('justifyLeft', false);
	});
	$("#justifyRight").click(function() {
		document.execCommand('justifyRight', false);
	});
	$("#justifyCenter").click(function() {
		document.execCommand('justifyCenter', false);
	}); 
	$('select').change(function(){
		document.execCommand($(this).attr('id'), false, $(this).val());
	});
	$("#foreColor").change(function(){
		document.execCommand('foreColor', false, $(this).val());
	});
	$("#hiliteColor").change(function(){
		document.execCommand('hiliteColor', false, $(this).val());
	});
	$("#fontName").change(function(){
		document.execCommand('fontName', false, $(this).val());
	});
	$("#fontSize").change(function(){
		document.execCommand('fontSize', false, $(this).val());
	});
	//var $ttd = $('#ttd').DataTable();
	 

	 //editor = $.fn.dataTable.Editor;
	 /* new editor;
	 new $.fn.dataTable.Editor( {
		    table: '#ttd',
		    fields: [
		        { label: 'First name', name: 'first_name' },
		        { label: 'Last name',  name: 'last_name'  },
		        // etc
		    ]
		} ); */
	  
	
    // There's the wigetBox and the trash
	var $wigetBox = $( "#wigetBox" ),
	$trash = $( "#trash" );
 	
    $trash.resizable({
    	maxWidth: 1000
    });
    
    
    // Let the wigetBox items be draggable
    $( "li", $wigetBox ).draggable({
		cancel: "a.ui-icon", // clicking an icon won't initiate dragging
		revert: "invalid", // when not dropped, the item will revert back to its initial position
		containment: "document",
		helper: "clone",
		cursor: "move"
    });
 
    
    
    
    // Let the trash be droppable, accepting the wigetBox items
    $trash.droppable({
		//accept: "#wigetBox > li",
		classes: {
        	"ui-droppable-active": "ui-state-highlight"
      	},
      	drop: function( event, ui ) {
      		for(var i=1; i<valueNum; i++){
      			if(ui.draggable.val() == i){
      				deleteImage( ui.draggable, i );
      				break;
      			}
      		}
      		
        		
      	}
    });
 
    // Let the wigetBox be droppable as well, accepting items from the trash
    $wigetBox.droppable({
		accept: "#trash li",
		classes: {
        	"ui-droppable-active": "custom-state-active"
      	},
      	drop: function( event, ui ) {
        	recycleImage( ui.draggable );
      	}
    });
 
    // Image deletion function
	var recycle_icon = "<a href='link/to/recycle/script/when/we/have/js/off' title='Recycle this image' class='ui-icon ui-icon-refresh'>Recycle image</a>";
    function deleteImage( $item, num ) {
    	
		$item.fadeOut(function() {
	        var $list = $trash;
	 		
			var value = $item.val();
			
			
			
			//textBox위젯기능
			if(value == "1"){
				var text = "<div class='drag_text' style='height:100px; width: 100px; border: 1px black solid'><div contenteditable='true' class='wrap'></div></div>";
				$(text).appendTo( $list ).fadeIn(function() {
					$item.animate({ width: "96px" })
						 .animate({ height: "72px" });
					
					$( ".drag_text").resizable({
	        	    	containment: "#trash"
	        	    });
					
					
					$("#wigetBox").prepend('<li class="ui-widget-content ui-corner-tr" value="1">'
			    			 +'<h5 class="ui-widget-header">TextBox</h5>'
			    			 +'<img src="resources/img/icon_textbox.png" alt="The peaks of High Tatras" width="96" height="72">'
			  				 +'</li>');	
					   
					
					$( ".drag_text").draggable({
						revert: "invalid"
					}).click(function() {
						$(this).attr('contenteditable', true);
						$(this).draggable({
							disabled: true
						});
					}).blur(function() {
						$(this).attr('contenteditable', false);
						$(this).draggable({
							disabled: false
						});
					});

					
					
					
				});
			}
			
			
			//table위젯기능
			else if(value == "2"){
				var table = "<table border='1' class='tables'><tr><td><div contenteditable='true' style='width:100%; height:100%'></div></td><td><input type='text'></td></tr>"
							+ "<tr><td><input type='text'></td><td><input type='text'></td></tr>"
							+ "<tr><td><input type='text'></td><td><input type='text'></td></tr></table>";
				$(table).appendTo( $list ).fadeIn(function() {
					$item.animate({ width: "96px" })
						 .animate({ height: "72px" });
					
					$( ".tables").resizable({
	        	    	containment: "#trash"
	        	    });
					
					
					$("#wigetBox li:nth-child(1)").after('<li class="ui-widget-content ui-corner-tr" value="2">'
			    			 +'<h5 class="ui-widget-header">Table</h5>'
			    			 +'<img src="resources/img/icon_table.png" alt="The peaks of High Tatras" width="96" height="72">'
			  				 +'</li>');	
					
					$( ".tables").draggable();
				});
			}
			
			//이미지위젯기능
			else if(value == "3"){
				var img = '<div class="drag_img" style="border: 1px solid black; width:96px; height: 72px"><img src="resources/img/ebphone.jpg" class="img" alt="On top of Kozi kopka" width="96" height="72"></div>';
				$(img).appendTo( $list ).fadeIn(function() {
					$item.animate({ width: "96px" })
						 .animate({ height: "72px" });
					
					$( ".drag_img").resizable({
	        	    	containment: "#trash"
	        	    });
					
					
					$("#wigetBox li:nth-child(2)").after('<li class="ui-widget-content ui-corner-tr" value="3">'
			    			 +'<h5 class="ui-widget-header">이미지</h5>'
			    			 +'<img src="resources/img/ebphone.jpg" alt="On top of Kozi kopka" width="96" height="72">'
			  				 +'</li>');	
					
					var ii = $( ".drag_img").draggable({
						revert : "invalid"
					});
					
					
				});
			}
			
			else {
				var src = $('#file'+num).attr('src');
				var img = '<div class="drag_img" style="border: 1px solid black; width:96px; height: 72px"><img src="'+src+'" class="img"width="96" height="72"></div>';
				$(img).appendTo( $list ).fadeIn(function() {
					$item.animate({ width: "96px" })
						 .animate({ height: "72px" });
					
					$( ".drag_img").resizable({
	        	    	containment: "#trash"
	        	    });
					
					
					$("#wigetBox li:nth-last-child(1)").after('<li class="ui-widget-content ui-corner-tr" value="'+num+'">'
			    			 +'<h5 class="ui-widget-header">이미지</h5>'
			    			 +'<img src="'+src+'" width="96" height="72" id="file'+num+'">'
			  				 +'</li>');
					
					var ii = $( ".drag_img").draggable({
						revert : "invalid"
					});

				});
			}//else
	        
			
			//drag이벤트초기화
			$( "li", $wigetBox ).draggable({
				cancel: "a.ui-icon", // clicking an icon won't initiate dragging
				revert: "invalid", // when not dropped, the item will revert back to its initial position
				containment: "document",
				helper: "clone",
				cursor: "move"
		    });
			
			
			//$('#ttdiv').text($('#wigetBox').html());
			
		});
	}
 
    // Image recycle function
	/* var trash_icon = "<a href='link/to/trash/script/when/we/have/js/off' title='Delete this image' class='ui-icon ui-icon-trash'>Delete image</a>";
    function recycleImage( $item ) {
		$item.fadeOut(function() {
        $item
          .find( "a.ui-icon-refresh" )
            .remove()
          .end()
          .css( "width", "96px")
          .append( trash_icon )
          .find( "img" )
            .css( "height", "72px" )
          .end()
          .appendTo( $wigetBox )
          .fadeIn();
      });
    } */
    
    $("#upload").on("change",function(){
    	var fileNm = $("#upload").val();
   	 
    	if (fileNm != "") {
    	    var ext = fileNm.slice(fileNm.lastIndexOf(".") + 1).toLowerCase();
    	
    	    if (!(ext == "gif" || ext == "jpg" || ext == "png" || ext == "mp4")) {
    	        alert("이미지파일 (.jpg, .png, .gif ) 과 동영상파일(.mp4)만 업로드 가능합니다.");
    	        return false;
    	    }
    	}
    	
		var formData = new FormData();
		formData.append("file",$("#upload")[0].files[0]);
		
		$.ajax({
			type:"POST",						
			url:"fileupload",				
			data:formData,
			processData: false,
		    contentType: false,
			dataType:"text",				
			success:function(data){	
				console.log(data);
				$("#wigetBox li:nth-last-child(1)").after('<li class="ui-widget-content ui-corner-tr" value="'+valueNum+'">'
		    			 +'<h5 class="ui-widget-header">이미지</h5>'
		    			 +'<img src="'+data+'" width="96" height="72" id="file'+valueNum+'">'
		  				 +'</li>');
				
				$( "li", $wigetBox ).draggable({
					cancel: "a.ui-icon", // clicking an icon won't initiate dragging
					revert: "invalid", // when not dropped, the item will revert back to its initial position
					containment: "document",
					helper: "clone",
					cursor: "move"
			    });
				valueNum++;
			},
			error: function(e){			
				console.log(e);
			}
		});
	});
      
    $('#seebtn').on('click', function () {
		var save = $('#trash').html();
		$('#ttdiv').html(save);
	});
    $('#savebtn').on('click', function () {
		var html = $('#trash').html();
		$('#saveDiv').val(html);
		$('#saveForm').submit();
		/* $.ajax({
			type:"POST",						
			url:"portSave",				
			data: {
				html : html
			},
			dataType:"text",				
			success:function(data){
				alert(data);
			},
			error: function(e){			
				console.log(e);
			}
		}); */
	});
});	//function종료
  

  </script>
  
</head>
<body>
	

<div class="ui-widget ui-helper-clearfix">
 
	<div id="trash" class="ui-widget-header" style=" top:100px; width: 1000px; height: 700px; border: 1px black solid"></div>
	
	<div id="sidebox" class="sidebox">
		<input type="button" value="미리보기" id="seebtn">
		<input type="button" value="저장" id="savebtn">
		<ul id="wigetBox" class="wigetBox ui-helper-reset ui-helper-clearfix">
		  <li class="ui-widget-content ui-corner-tr" value="1">
		    <h5 class="ui-widget-header">TextBox</h5>
		    <img src="resources/img/icon_textbox.png" width="96" height="72">
		  </li>
		  <!-- <li class="ui-widget-content ui-corner-tr" value="2">
		    <h5 class="ui-widget-header">Table</h5>
		    <img src="resources/img/icon_table.png" width="96" height="72">
		  </li>
		  <li class="ui-widget-content ui-corner-tr" value="3">
		    <h5 class="ui-widget-header">이미지</h5>
		    <img src="resources/img/ebphone.jpg" width="96" height="72">
		  </li> -->
		</ul>
		    <input type=file name="file1" id="upload" style="display: none;" accept=".gif, .jpg, .png, .mp4">
		    <img class="addfile" src="resources/img/plus.png" width="96" height="72" onclick="document.all.file1.click()">
		  	
	</div>
</div>

	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
	
	<div class="textEditBox" id="textEditBox">
		<img src="/www/resources/img/bold.png" class="textEditIcon" id="bold" >
		<img src="/www/resources/img/italic.png" class="textEditIcon" id="italic">
		<img src="/www/resources/img/underline.png" class="textEditIcon" id="underLine">
		
		<img src="/www/resources/img/left_sort.png" class="textEditIcon" id="justifyLeft">
		<img src="/www/resources/img/center_sort.png" class="textEditIcon" id="justifyCenter">
		<img src="/www/resources/img/right_sort.png" class="textEditIcon" id="justifyRight">
		
		<select id="fontName" width="50px">
	        <option value="">글꼴</option>
	        <option value="돋움">돋움</option>
	        <option value="굴림">굴림</option>
	        <option value="궁서">궁서</option>
	        <option value="바탕">바탕</option>
	        <option value="맑은 고딕">맑은 고딕</option>
    	</select>
    	
    	<select id="fontSize" width="50px">
	        <option value="">글자크기</option>
	        <option value="1">4px</option>
	        <option value="2">8px</option>
	        <option value="3">10px</option>
	        <option value="4">12px</option>
	        <option value="5">16px</option>
	        <option value="6">20px</option>
	        <option value="7">30px</option>
    	</select>
		
		
    	<select id="foreColor" width="50px">
	        <option value="">글자 색깔</option>
	        <option value="#f00" style="background-image: url('/www/resources/img/bold.png');">빨강</option>
	        <option value="#00f">파랑</option>
	        <option value="#0f0">초록</option>
	        <option value="#ffff00">노랑</option>
	        <option value="#000">검정</option>
    	</select>

		
    	<select id="hiliteColor" width="50px">
	        <option value="">글자 배경색</option>
	        <option value="#f00">빨강</option>
	        <option value="#00f">파랑</option>
	        <option value="#0f0">초록</option>
	        <option value="#ffff00">노랑</option>
	        <option value="#000">검정</option>
    	</select>

  </div>
  
  <div id="ttdiv"></div>
  
  <form action="jspFileTest" method="post" id="saveForm">
  	<input type="hidden" id="saveDiv" name="html" value="">
  </form>
</body>
</html>