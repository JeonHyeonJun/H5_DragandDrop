<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>jQuery UI Droppable - Simple photo manager</title>

<!-- jquery, jquery-ui, 위젯에 필요한 css -->
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="resources/css/wiget.css">

<!-- graph -->
<script src="resources/graph/js/ion.rangeSlider.js"></script>
<script src="resources/graph/js/colpick.js" type="text/javascript"></script>
<script src="resources/graph/dist/roundslider.min.js"></script>
<link rel="stylesheet" href="resources/graph/css/normalize.css" />
<link rel="stylesheet" href="resources/graph/css/ion.rangeSlider.css" />
<link rel="stylesheet" href="resources/graph/css/ion.rangeSlider.skinFlat.css" />
<link rel="stylesheet" href="resources/graph/css/colpick/colpick.css" type="text/css"/>
<link href="resources/graph/dist/roundslider.min.css" rel="stylesheet" />

<script src="resources/graph/js/jquery.barrating.min.js"></script>
<link href="http://fonts.googleapis.com/css?family=Lato:300,400" rel="stylesheet" type="text/css">
<link href="http://fonts.googleapis.com/css?family=Source+Code+Pro" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="resources/graph/dist/barrating/themes/bars-1to10.css">
<link rel="stylesheet" href="resources/graph/dist/barrating/themes/bars-movie.css">
<link rel="stylesheet" href="resources/graph/dist/barrating/themes/bars-square.css">
<link rel="stylesheet" href="resources/graph/dist/barrating/themes/bars-pill.css">
<link rel="stylesheet" href="resources/graph/dist/barrating/themes/bars-reversed.css">
<link rel="stylesheet" href="resources/graph/dist/barrating/themes/bars-horizontal.css">
<link rel="stylesheet" href="resources/graph/dist/barrating/themes/fontawesome-stars.css">
<link rel="stylesheet" href="resources/graph/dist/barrating/themes/css-stars.css">
<link rel="stylesheet" href="resources/graph/dist/barrating/themes/bootstrap-stars.css">
<link rel="stylesheet" href="resources/graph/dist/barrating/themes/fontawesome-stars-o.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">

<!-- table -->


<style type="text/css">
	.ui-side1{
		position: absolute;
		left : 130px;
		top : 250px;
		display : none;
	}
</style>
<script>
document.execCommand('styleWithCSS', false, true);

document.execCommand('insertBrOnReturn', false, true);

var shapeselect;
var setr;
var setp;
var seth;
var setb;
var val;

var eTable;
var graph_click = false;

var graphNum = 0;

$( function() {
	
	$('#textEditBox').draggable();
	$('#sidebox').draggable();
	var pageX = 0;		//위젯드롭했을때 좌표값 받기위한변수x
	var pageY = 0;		//위젯드롭했을때 좌표값 받기위한변수y
	$(document).mousemove(function(e){
		//마우스 움직일때 좌표저장
		pageX = e.pageX;		
		pageY = e.pageY;
     });
	
	var valueNum = 6;	//임의의 파일(이미지,동영상)추가에 줄 값
	
	//스크롤에 맞춰 따라다니는 위젯박스+텍스트에디터
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
	  
	//텍스트에디터 이벤트
	$('.textEditIcon').click(function(){
		document.execCommand($(this).attr('id'), false, true);
	});
	$('select').change(function(){
		document.execCommand($(this).attr('id'), false, $(this).val());
	});
	
    // 위젯박스, 포트폴리오영역 변수지정
	var $wigetBox = $( "#wigetBox" ),
	$trash = $( "#trash" );
 	
	// 포트폴리오영역 resizable이벤트 생성
	if(${html == null}){
		$trash.resizable({
			maxWidth: 1000,
			autoHide: true
		});
		$trash.css('width', '1000px');
		$trash.css('height', '700px');
	}
	
	$('#graph_1').on('click', function() {
		if(graph_click){
			$(this).children('ul').css('display', 'none');
			graph_click = false;
		}
		else{
			$(this).children('ul').css('display', 'block');
			graph_click = true;
		}
			
		
	});
    
   
    // 위젯 드래그 이벤트 생성
    $( "li", $wigetBox ).draggable({
		cancel: "a.ui-icon", // clicking an icon won't initiate dragging
		revert: "invalid", // when not dropped, the item will revert back to its initial position
		containment: "document",
		helper: "clone",
		cursor: "move"
    });
 	
    
    // 포트폴리오 영역에 드롭이벤트 생성
    $trash.droppable({
		classes: {
        	"ui-droppable-active": "ui-state-highlight"
      	},
      	//드롭되었을때
      	drop: function( event, ui ) {
      		for(var i=1; i<valueNum; i++){
      			if(ui.draggable.val() == i){
      				insertWiget( ui.draggable, i, pageX, pageY-100 );	//드롭된게 위젯에서 가져온거면 insertWiget함수 실행
      				break;
      			}
      		}
      	}//drop
    });
 
    
	// 위젯 드롭됐을때 생성하는 함수
	function insertWiget( $item, num, x, y ) {
    	
		$item.fadeOut(function() {
	        var $list = $trash;		//포트폴리오 영역
	 		
			var value = $item.val();	//위젯의 value값
			
			
			
			//textBox위젯기능
			if(value == "1"){
				//텍스트박스 html태그 변수생성
				var text = "<div class='drag_text' style='position:absolute; height:100px; width: 100px; left:"+x+"px; top:"+y+"px;' >"
						 + "<img class='close' style='position:absolute; float:right;' src='resources/img/close.png' width='20px' height='20px'>"
						 + "<div contenteditable='true' class='edit_text'></div></div>";
				//포트폴리오영역에 텍스트박스html태그 추가
				$(text).appendTo( $list ).fadeIn(function() {
					$item.animate({ width: "96px" })
						 .animate({ height: "72px" });
					//resizable이벤트생성
					initResizable('.drag_text', num);
					
					//위젯box에 텍스트박스 다시 생성
					$("#wigetBox").prepend('<li class="ui-widget-content ui-corner-tr" value="1">'
			    			 +'<h5 class="ui-widget-header">TextBox</h5>'
			    			 +'<img src="resources/img/icon_textbox.png" width="96" height="72">'
			  				 +'</li>');	
					   
					//넣은 텍스트박스에 드래그이벤트생성
					$( ".drag_text").draggable({
						revert: "invalid"	//포트폴리오영역 밖으로 나가면 제자리로 되돌아오는 속성
					}).click(function() {
						//클릭시 편집가능
						$(this).draggable({
							disabled: true
						});
						
					});
					
					$('.edit_text').focus();
					
					$('.edit_text').blur(function() {
						//focus벗어나면 편집불가능
						$(".drag_text").draggable({
							disabled: false
						});
					});	
					
					initCloseBtn('.drag_text');
				});//fadeIn
			}//if(value=="1")
			
			
			//table위젯기능
			else if(value == "2"){
				var table = "<div class='drag_table' style='position:absolute; left:"+x+"px; top:"+y+"px;'>"
						  + "<img class='close' style='position:absolute; float:right;' src='resources/img/close.png' width='20px' height='20px'>"
				  		  + "<textarea class='table' style='display:none;' name='myField'></textarea>"
				  		  + "</div>";
				$(table).appendTo( $list ).fadeIn(function() {
					$item.animate({ width: "96px" })
						 .animate({ height: "72px" });
					
					eTable = $('.table').editTable();
					
					$("#updatetoggle").click(function() {
						$(".addrowtd").slideToggle("slow");
						$(".addcolth").slideToggle("slow");
					});
					$(".inputtable").resizable({
						containment: "#trash",
				    	autoHide: true,
				    	resize: function( event, ui ) {
				    		$(this).parents('.drag_table').css('width', ui.size.width);
				    	}
					});
					
					$("#wigetBox > li:nth-child(1)").after('<li class="ui-widget-content ui-corner-tr" value="2">'
			    			 +'<h5 class="ui-widget-header">Table</h5>'
			    			 +'<img src="resources/img/icon_table.png" width="96" height="72">'
			  				 +'</li>');	
					
					$( ".drag_table").draggable({
						revert : "invalid"
					});
					
					initCloseBtn('.drag_table');
				});
			}
			
			//바그래프
			else if(value == "3"){
				var graph = "<div class='drag_graph' style='position:absolute; width:100px; height: 100px; left:"+x+"px; top:"+y+"px;'>"
						  + "<img class='close' src='resources/img/close.png' width='20px' height='20px'>"
						  + "<input type='text' id='bargraph"+graphNum+"' value='' /></div>";
				
				$(graph).appendTo( $list ).fadeIn(function() {
					$item.animate({ width: "96px" })
						 .animate({ height: "72px" });
					
					$("#bargraph"+graphNum).ionRangeSlider({
						min : 0,
						max : 100,
						hide_min_max : true
					/*          hide_from_to: true  최소값 최대값 보이기*/
					});
					
					initResizable('.drag_graph', num);
					
					//넣었던 이미지 위젯에 다시생성
					$("#graph_1 ul").prepend('<li class="ui-widget-content ui-corner-tr" value="'+num+'">'
			    			 +'<h5 class="ui-widget-header">바그래프</h5>'
			    			 +'<img src="resources/img/icon_bargraph.png">'
			  				 +'</li>'); 
					
					//추가한 이미지에 드래그 이벤트 생성
					$( ".drag_graph").draggable({
						revert : "invalid"
					});
					
					initCloseBtn('.drag_graph');
					
					graphNum++;
				});
				
			}
			
			else if(value == "4"){
				var graph = "<div class='drag_graph' style='position:absolute; width:200px; height:230px; left:"+x+"px; top:"+y+"px;'>"
						  + "<img class='close' style='position:absolute; float:right;' src='resources/img/close.png' width='20px' height='20px'>"
						  + "<input type='button' value='편집' class='edit_graph_btn'>"
						  + "<input type='button' value='드래그' class='drag_graph_btn'>"
						  + "<div class='slider' id='slider"+graphNum+"'></div>"
						  + "</div>";
				
				$(graph).appendTo( $list ).fadeIn(function() {
					$item.animate({ width: "96px" })
						 .animate({ height: "72px" });
					
					change();
					
					initResizable('.drag_graph', num);
					
					//넣었던 이미지 위젯에 다시생성
					$("#graph_1 li:nth-child(1)").after('<li class="ui-widget-content ui-corner-tr" value="'+num+'">'
			    			 +'<h5 class="ui-widget-header">원그래프</h5>'
			    			 +'<img src="resources/img/icon_circlegraph.png">'
			  				 +'</li>'); 
					
					//추가한 이미지에 드래그 이벤트 생성
					$( ".drag_graph").draggable({
						revert : "invalid"
					});
					
			  		$('.edit_graph_btn').on('click', function() {
			  			$(".slider").roundSlider("enable");
			  			$( ".drag_graph").draggable({
							disabled : true
						});
					});
			  		
					$('.drag_graph_btn').on('click', function() {
						$(".slider").roundSlider("disable");
						$( ".drag_graph").draggable({
							disabled : false
						});
					});
					
					initCloseBtn('.drag_graph');
					
					graphNum++;
				});
				
			}
			
			else if(value == "5"){
				var graph = '<div class="drag_stargraph" style="width:100px; left:'+x+'px; top:'+y+'px;">'
						  + '<img class="close" src="resources/img/close.png" width="20px" height="20px">'
						  + 	'<select id="stargraph'+graphNum+'">'
				  		  + 		'<option value="1">1</option>'
				  		  + 		'<option value="2">2</option>'
				  		  + 		'<option value="3">3</option>'
				  		  + 		'<option value="4">4</option>'
				  		  + 		'<option value="5">5</option>'
				  		  + 	'</select>'
				  		  + '</div>';
				  		  
				$(graph).appendTo( $list ).fadeIn(function() {
					$item.animate({ width: "96px" })
						 .animate({ height: "72px" });
					
					$('#stargraph'+graphNum).barrating({
				        theme: 'fontawesome-stars'
				      });
					
					//넣었던 이미지 위젯에 다시생성
					$("#graph_1 li:nth-child(2)").after('<li class="ui-widget-content ui-corner-tr" value="'+num+'">'
			    			 +'<h5 class="ui-widget-header">별그래프</h5>'
			    			 +'<img src="resources/img/icon_stargraph.png">'
			  				 +'</li>'); 
					
					//추가한 이미지에 드래그 이벤트 생성
					$( ".drag_stargraph").draggable({
						revert : "invalid"
					});
					
					initCloseBtn('.drag_stargraph');
					graphNum++;
				});
			}
			
			//추가한 이미지위젯 기능
			else {
				var src = $('#file'+num).attr('src');	//id가 'file'+num인태그에 src속성추가
				//이미지 html태그 변수생성
				var img = '<div class="drag_img" style="position:absolute; width:96px; height: 72px; left:'+x+'px; top:'+y+'px;">'
						+ '<img class="close" style="position:absolute;" src="resources/img/close.png" width="20px" height="20px">'
						+ '<img src="'+src+'" class="img"></div>';
				//이미지 포트폴리오영역에 추가
				$(img).appendTo( $list ).fadeIn(function() {
					$item.animate({ width: "96px" })
						 .animate({ height: "72px" });
					//이미지에 resizable이벤트 생성
					initResizable('.drag_img', num);
					
					//넣었던 이미지 위젯에 다시생성
					$("#wigetBox > li:nth-last-child(1)").after('<li class="ui-widget-content ui-corner-tr" value="'+num+'">'
			    			 +'<h5 class="ui-widget-header">이미지</h5>'
			    			 +'<img src="'+src+'" id="file'+num+'">'
			  				 +'</li>');
					
					//추가한 이미지에 드래그 이벤트 생성
					$( ".drag_img").draggable({
						revert : "invalid"
					});

					initCloseBtn('.drag_img');
				});//fadeIn
			}//else
	        
			
			//위젯box drag이벤트초기화
			$( "li", $wigetBox ).draggable({
				cancel: "a.ui-icon", // clicking an icon won't initiate dragging
				revert: "invalid", // when not dropped, the item will revert back to its initial position
				containment: "document",
				helper: "clone",
				cursor: "move"
		    });
			

		});//fadeOut
	}//insertWiget
 

    //이미지추가기능
    $("#upload").on("change",function(){
    	var fileNm = $("#upload").val();	//업로드하려는 파일의 value값
   	 
    	//이미지 파일인지 검사
    	if (fileNm != "") {
    	    var ext = fileNm.slice(fileNm.lastIndexOf(".") + 1).toLowerCase();
    	
    	    if (!(ext == "gif" || ext == "jpg" || ext == "png")) {
    	        alert("이미지파일 (.jpg, .png, .gif )만 업로드 가능합니다.");
    	        return false;
    	    }
    	}
    	
		var formData = new FormData();
		formData.append("file",$("#upload")[0].files[0]);
		
		//위젯에 업로드한 이미지 추가
		$.ajax({
			type:"POST",						
			url:"fileupload",				
			data:formData,
			processData: false,
		    contentType: false,
			dataType:"text",				
			success:function(data){	
				console.log(data);
				$("#wigetBox > li:nth-last-child(1)").after('<li class="ui-widget-content ui-corner-tr" value="'+valueNum+'">'
		    			 +'<h5 class="ui-widget-header">이미지</h5>'
		    			 +'<img src="'+data+'" width="96px" height="72px" id="file'+valueNum+'">'
		  				 +'</li>');
				
				$( "li", $wigetBox ).draggable({
					cancel: "a.ui-icon",
					revert: "invalid",
					containment: "document",
					helper: "clone",
					cursor: "move"
			    });
				
				valueNum++;	//성공시 img에 줄 value값 1증가(아이디랑 value값 안겹치게하기위함)
			},
			error: function(e){			
				console.log(e);
			}
		});//ajax
	});//change이벤트
      
	//실험용버튼
    $('#seebtn').on('click', function () {
		var save = $('#trash').html();
		$('#ttdiv').text(save);
	});
    
    //저장버튼
    $('#savebtn').on('click', function () {
    	$('.edit_text').attr('contenteditable', false);	//텍스트박스 편집기능제거
    	//resizable이벤트제거
    	$('#trash').resizable('destroy');				
    	$( ".drag_text").resizable('destroy');
    	$( ".drag_img").resizable('destroy');
    	
    	if(eTable != null){
    		var json = JSON.parse(eTable.getJsonData());
        	var cnt = 0;
        	for(var i=0; i<json.length; i++){
        		for(var j=0; j<json[i].length; j++){
        			$(".inputtable .hi2td:eq("+cnt+")").html("<input type='text' value='"+json[i][j]+"'>");
        			cnt++;
        		}	
        	}
    	}
    	
    	$(".addrowtd").hide();
		$(".addcolth").hide();
		$("#updatetoggle").hide();
		$("#complete").hide();
		
		$('.edit_graph_btn').css('display', 'none');
		$('.drag_graph_btn').css('display', 'none');
		
		$('#graphNum').remove();
		$('#trash').prepend('<input type="hidden" id="graphNum" value="'+graphNum+'">');
    	var width = $('#trash').css('width');
    	var height = $('#trash').css('height');
		var html = $('#trash').html();	//포트폴리오영역의 html태그 전부 변수에 저장
		$('#saveDiv').val(html);		//hidden폼에 html태그 저장
		$('#div_width').val(width);
		$('#div_height').val(height);
		
		$('#saveForm').submit();		//전송
	});
    
    //포트폴리오 수정일때(이페이지에 넘어온값이 있을때)
    if(${html != null}) {
    	
    	$trash.css('width', '${width}');
		$trash.css('height', '${height}');
		
    	$trash.html('${html}');		//포트폴리오영역에 넘어온값 추가
    	graphNum = $('#graphNum').val();
    	//여러가지 이벤트 초기화
    	$trash.resizable({
    		maxWidth: 1000,
    		autoHide: true
    	});
    	$('.edit_text').attr('contenteditable', true);
    	
    	$( ".drag_text").draggable({
			revert: "invalid"	//포트폴리오영역 밖으로 나가면 제자리로 되돌아오는 속성
		}).click(function() {
			//클릭시 편집가능
			$(this).draggable({
				disabled: true
			});
			
		});
		$('.edit_text').blur(function() {
			//focus벗어나면 편집불가능
			$(".drag_text").draggable({
				disabled: false
			});
		});	
    	
    	$( ".drag_img").draggable({
			revert : "invalid"
		});
    	
    	$( ".drag_graph").draggable({
			revert : "invalid"
		});
    	
    	$( ".drag_stargraph").draggable({
			revert : "invalid"
		});
    	
    	$( ".drag_table").draggable({
			revert : "invalid"
		});
    	
    	initResizable('.drag_text', 1);
    	initResizable('.drag_graph', 4);
    	initResizable('.drag_img', 0);
    	
    	initCloseBtn('.drag_text');
    	initCloseBtn('.drag_graph');
    	initCloseBtn('.drag_stargraph');
    	initCloseBtn('.drag_img');
    	initCloseBtn('.drag_table');
    	
    	$(".addrowtd").show();
		$(".addcolth").show();
		$("#updatetoggle").show();
		$("#complete").show();
    	
		$('.edit_graph_btn').css('display', 'block');
		$('.drag_graph_btn').css('display', 'block');
		
    }//if
	
    

});	/* //function종료 */

function complete(){
	 $(".inputtable").resizable('destroy');
	 $(".hi2td").resizable('destroy');
}

function initCloseBtn(className) {
	$('.close').on('click', function() {
    	var tag = $(this).parent();
    	tag.remove();
	});
	
	$(className).hover(function() {
		$(this).find('.close').css('display', 'block');
	}, function() {
		$(this).find('.close').css('display', 'none');
	});
}

function initResizable(className, valueNum) {
	
	if(valueNum == 4){
		$(className).resizable({
			containment: "#trash",
			autoHide: true,
	    	resize: function( event, ui ) {
	    		$(this).children('.slider').roundSlider({
	    			width : ui.size.width/5,
	    			radius : (ui.size.height+ui.size.width)/4
	    		})
	    	}
	    });
	}
	
	else{
		$(className).resizable({
	    	containment: "#trash",
	    	autoHide: true
	    });
	}
	
	
}
function change(){
	 shapeselect = $("#target option:selected").text();
		
		$(".slider").roundSlider({
			sliderType : "min-range",
			width : 32,
			radius : 100,
			value : val,
			keyboardAction : false,
			mouseScrollAction : true,
			handleShape : shapeselect
		});
		
		$(".slider").on("change", function (e) {
			val = e.value;
		}); 
		
}

$(function() {

		$('#color-box-range').colpick({
			colorScheme:'dark',
			layout:'rgbhex',
			color:'#54BBE0',
			onSubmit:function(hsb,hex,rgb,el) {
				$(el).css('background-color', '#'+hex);
				setr = '#'+hex;
				$(el).colpickHide();
				$('.rs-range-color').css('background-color', setr);
				//change();
			}
		}).css('background-color', '#54BBE0');
		
	});
$(function() {

		$('#color-box-path').colpick({
			colorScheme:'dark',
			layout:'rgbhex',
			color:'#d4d0d4',
			onSubmit:function(hsb,hex,rgb,el) {
				$(el).css('background-color', '#'+hex);
				setp = '#'+hex;
				$(el).colpickHide();
				$('.rs-path-color').css('background-color', setp);
				change();
			}
		}).css('background-color', '#d4d0d4');
		
	});
$(function() {

		$('#color-box-handle').colpick({
			colorScheme:'dark',
			layout:'rgbhex',
			color:'#838383',
			onSubmit:function(hsb,hex,rgb,el) {
				$(el).css('background-color', '#'+hex);
				seth = '#'+hex;
				$(el).colpickHide();
				$('.rs-handle').css('background-color', seth);
				change();
			}
		}).css('background-color', '#838383');
		
	});
$(function() {

		$('#color-box-background').colpick({
			colorScheme:'dark',
			layout:'rgbhex',
			color:'#d4d0d4',
			onSubmit:function(hsb,hex,rgb,el) {
				$(el).css('background-color', '#'+hex);
				setb = '#'+hex;
				$(el).colpickHide();
				$('.rs-bg-color').css('background-color', setb);
				change();
			}
		}).css('background-color', '#d4d0d4');
		
	});
	
</script>
  
</head>
<body>


<div id="graphColor">
	<div>handleShape</div>
	
	<select name="target" id="target" onchange="change()">
	    <option value="round">round</option>
	    <option value="dot">dot</option>
	    <option value="square">square</option>
	  </select>
	  
	<div class="divTable" style="border: 2px solid #000;">
		<div class="divTableBody">
			<div class="divTableRow">
				<div class="divTableCell">range</div>
				<div class="color-box" id="color-box-range"></div>
				<div class="divTableCell">path</div>
				<div class="color-box" id="color-box-path"></div>
				<div class="divTableCell">handle</div>
				<div class="color-box" id="color-box-handle"></div>
				<div class="divTableCell">background</div>
				<div class="color-box" id="color-box-background"></div>
			</div>
		</div>
	</div>
</div>
<!-- DivTable.com -->

<div class="ui-widget ui-helper-clearfix">
 
 	<!-- 포트폴리오 영역 -->
 	<c:if test="${html == null }">
 		<div id="trash" class="ui-widget-header" style=" top:100px; border: 1px black solid"></div>
	</c:if>
	<c:if test="${html != null }">
 		<div id="trash" class="ui-widget-header" style=" top:100px; border: 1px black solid"></div>
	</c:if>
	<!-- 위젯영역 -->
	<div id="sidebox" class="sidebox">
		<input type="button" value="미리보기" id="seebtn">
		<input type="button" value="저장" id="savebtn">
		<ul id="wigetBox" class="wigetBox ui-helper-reset ui-helper-clearfix">
		  <li class="ui-widget-content ui-corner-tr" value="1">
		    <h5 class="ui-widget-header">TextBox</h5>
		    <img src="resources/img/icon_textbox.png" width="96" height="72">
		  </li>
		  <li class="ui-widget-content ui-corner-tr" value="2">
		    <h5 class="ui-widget-header">Table</h5>
		    <img src="resources/img/icon_table.png" width="96" height="72">
		  </li>
		  <li class="ui-widget-content ui-corner-tr" id="graph_1" style="cursor: pointer;">
		    <h5 class="ui-widget-header">그래프</h5>
		    <img src="resources/img/icon_graph.png" width="96" height="72">
		    <ul class="wigetBox ui-helper-reset ui-helper-clearfix ui-side1">
		    	<li class="ui-widget-content ui-corner-tr" value="3" >
		    		<h5 class="ui-widget-header">바그래프</h5>
		    		<img src="resources/img/icon_bargraph.png" width="96" height="72">
		    	</li>
		    	<li class="ui-widget-content ui-corner-tr" value="4" >
		    		<h5 class="ui-widget-header">원그래프</h5>
		    		<img src="resources/img/icon_circlegraph.png" width="96" height="72">
		    	</li>
		    	<li class="ui-widget-content ui-corner-tr" value="5" >
		    		<h5 class="ui-widget-header">별그래프</h5>
		    		<img src="resources/img/icon_stargraph.png" width="96" height="72">
		    	</li>
		    </ul>
		  </li>
		 <!--  <li class="ui-widget-content ui-corner-tr" value="4">
		    <h5 class="ui-widget-header">원그래프</h5>
		    <img src="resources/img/icon_graph.png" width="96" height="72">
		  </li>
		  <li class="ui-widget-content ui-corner-tr" value="5">
		    <h5 class="ui-widget-header">별그래프</h5>
		    <img src="resources/img/icon_graph.png" width="96" height="72">
		  </li> -->
		</ul>
		<input type=file name="file1" id="upload" style="display: none;" accept=".gif, .jpg, .png, .mp4">
		<img class="addfile" src="resources/img/plus.png" width="96" height="72" onclick="document.all.file1.click()">
	</div>
</div>

	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
	
<!-- 텍스트에디터 영역 -->
<div class="textEditBox" id="textEditBox">
	<img src="/www/resources/img/bold.png" class="textEditIcon" id="bold" >
	<img src="/www/resources/img/italic.png" class="textEditIcon" id="italic">
	<img src="/www/resources/img/underline.png" class="textEditIcon" id="underLine">
		
	<img src="/www/resources/img/left_sort.png" class="textEditIcon" id="justifyLeft">
	<img src="/www/resources/img/center_sort.png" class="textEditIcon" id="justifyCenter">
	<img src="/www/resources/img/right_sort.png" class="textEditIcon" id="justifyRight">
	<button id='updatetoggle'>테이블 수정</button>
	<br>
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
		<option value="">글자배경</option>
		<option value="#f00">빨강</option>
		<option value="#00f">파랑</option>
		<option value="#0f0">초록</option>
		<option value="#ffff00">노랑</option>
		<option value="#000">검정</option>
	</select>
</div>
  
  
  
	<button id="complete" onclick="complete()">완료</button>
	
  <div id="ttdiv"></div>
  
  <!-- 포트폴리오 저장을 위한 폼 -->
  <form action="jspFileTest" method="post" id="saveForm">
  	<input type="hidden" id="saveDiv" name="html" value="">
  	<input type="hidden" id="div_width" name="width" value="">
  	<input type="hidden" id="div_height" name="height" value="">
  </form>
  
</body>
<script src="resources/table/js/test4.js"></script>
<link rel="stylesheet" href="resources/table/css/jquery.edittable.min.css">
</html>