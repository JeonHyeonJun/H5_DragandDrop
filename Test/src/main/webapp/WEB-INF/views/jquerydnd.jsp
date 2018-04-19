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
<script src="resources/js/wiget_default.js"></script>
<script src="resources/js/wiget_table.js"></script>
<script src="resources/js/wiget_graph.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="resources/css/wiget.css">

<!-- graph -->
<script src="resources/graph/js/ion.rangeSlider.js"></script>
<script src="resources/graph/js/ion.rangeSlider2.js"></script>
<script src="resources/graph/js/colpick.js" type="text/javascript"></script>
<script src="resources/graph/dist/roundslider.min.js"></script>
<link rel="stylesheet" href="resources/graph/css/normalize.css" />
<link rel="stylesheet" href="resources/graph/css/ion.rangeSlider.css" />
<link rel="stylesheet" href="resources/graph/css/ion.rangeSlider.skinFlat.css" />
<link rel="stylesheet" href="resources/graph/css/ion.rangeSlider.skinModern.css" />
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
		left : 120px;
		top : 245px;
		display : none;
	}
	.ui-side2{
		position: absolute;
		left : 110px;
		top : 0px;
		display: none;
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
var jsonData;
var graphNum = 0;

$( function() {
	// 위젯박스, 포트폴리오영역 변수지정
	var $wigetBox = $( "#wigetBox" ),
	$trash = $( "#trash" );

	colpick();
	imgUpload();

	// 수정이 아닐때 포트폴리오영역 resizable이벤트 생성
	if(${html == null}){
		$trash.resizable({
			maxWidth: 1000,
			autoHide: true
		});
		$trash.css('width', '1000px');
		$trash.css('height', '700px');
	}

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
    	
    	//Table 내용 html코드에 저장
    	jsonData = JSON.stringify(exportData());
        if(jsonData != "[]"){
        	var json = JSON.parse(jsonData);
            var cnt = 0;
            for(var i=0; i<json.length; i++){
            	for(var j=0; j<json[i].length; j++){
            		$(".inputtable .hi2td:eq("+cnt+")").html("<input type='text' value='"+json[i][j]+"'>");
            		cnt++;
            	}	
            }
        }
    	
        $("input[type=text]").attr('readonly', true);
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
    	
    	$("input[type=text]").attr('readonly', false);
    	addcol();
    	addrow();
    	
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
		    	<li class="ui-widget-content ui-corner-tr" id="circle_graph">
		    		<h5 class="ui-widget-header">원그래프</h5>
		    		<img src="resources/img/icon_circlegraph.png" width="96" height="72">
		    		<ul class="wigetBox ui-helper-reset ui-helper-clearfix ui-side2">
				    	<li class="ui-widget-content ui-corner-tr" value="4" type="1">
				    		<h5 class="ui-widget-header">1</h5>
				    	</li>
				    	<li class="ui-widget-content ui-corner-tr" value="4" type="2">
				    		<h5 class="ui-widget-header">2</h5>
				    	</li>
				    	<li class="ui-widget-content ui-corner-tr" value="4" type="3">
				    		<h5 class="ui-widget-header">3</h5>
				    	</li>
				    	<li class="ui-widget-content ui-corner-tr" value="4" type="4">
				    		<h5 class="ui-widget-header">4</h5>
				    	</li>
		   			</ul>
		    	</li>
		    	<li class="ui-widget-content ui-corner-tr" id="etc_graph">
		    		<h5 class="ui-widget-header">단계그래프</h5>
		    		<img src="resources/img/icon_etc_graph.png" width="96" height="72">
		    		<ul class="wigetBox ui-helper-reset ui-helper-clearfix ui-side2">
				    	<li class="ui-widget-content ui-corner-tr" value="5" id="graph5_1">
				    		<h5 class="ui-widget-header">horizontal</h5>
				    	</li>
				    	<li class="ui-widget-content ui-corner-tr" value="5" id="graph5_2">
				    		<h5 class="ui-widget-header">movie</h5>
				    	</li>
				    	<li class="ui-widget-content ui-corner-tr" value="5" id="graph5_3">
				    		<h5 class="ui-widget-header">star</h5>
				    	</li>
		   			</ul>
		    	</li>
		    </ul>
		  </li>
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