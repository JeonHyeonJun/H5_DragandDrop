$(function() {
	$wigetBox = $( "#wigetBox" );	// 위젯박스부분 변수로 선언
	$trash = $( "#trash" );			// 포트폴리오부분 변수로 선언
	valueNum = 6;	//임의의 파일(이미지,동영상)추가에 줄 값
	$('#textEditBox').draggable();
	$('#sidebox').draggable();
	var pageX = 0;		//위젯드롭했을때 좌표값 받기위한변수x
	var pageY = 0;		//위젯드롭했을때 좌표값 받기위한변수y
	$(document).mousemove(function(e){
		//마우스 움직일때 좌표저장
		pageX = e.pageX;		
		pageY = e.pageY;
     });
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
	$('#graph_1').hover(function() {
		$(this).children('ul').css('display', 'block');
	}, function() {
		$(this).children('ul').css('display', 'none');
	});
	
	$('#circle_graph').hover(function() {
		$(this).children('ul').css('display', 'block');
	}, function() {
		$(this).children('ul').css('display', 'none');
	});
	
	$('#etc_graph').hover(function() {
		$(this).children('ul').css('display', 'block');
	}, function() {
		$(this).children('ul').css('display', 'none');
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
});	//$(function)종료
	

// 위젯제거버튼생성 함수
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

// 위젯 리사이즈생성 함수
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

//위젯 드롭
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
				
				
				
				$("#bargraph"+graphNum).ionRangeSlider2({
					min : 0,
					max : 100,
					hide_min_max : true
				/*          hide_from_to: true  최소값 최대값 보이기*/
				});
				
				 
				initResizable('.drag_graph', num);
				
				//넣었던 이미지 위젯에 다시생성
				$("#graph_1 > ul").prepend('<li class="ui-widget-content ui-corner-tr" value="'+num+'">'
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
		
		//원그래프
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
				
				var type = $item.attr("type");
				change(type, "slider"+graphNum);
				initResizable('.drag_graph', num);
				
				//넣었던 이미지 위젯에 다시생성
				if(type == 1){
					$("#circle_graph > ul").prepend('<li class="ui-widget-content ui-corner-tr" value="'+num+'" type="1">'
			    			 +'<h5 class="ui-widget-header">1</h5>'
			  				 +'</li>');
				}
				else if(type == 2){
					$("#circle_graph li:nth-child(1)").after('<li class="ui-widget-content ui-corner-tr" value="'+num+'" type="2">'
			    			 +'<h5 class="ui-widget-header">2</h5>'
			  				 +'</li>');
				}
				else if(type == 3){
					$("#circle_graph li:nth-child(2)").after('<li class="ui-widget-content ui-corner-tr" value="'+num+'" type="3">'
			    			 +'<h5 class="ui-widget-header">3</h5>'
			  				 +'</li>');
				}
				else if(type == 4){
					$("#circle_graph li:nth-child(3)").after('<li class="ui-widget-content ui-corner-tr" value="'+num+'" type="4">'
			    			 +'<h5 class="ui-widget-header">4</h5>'
			  				 +'</li>');
				}
				
				
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
		
		//단계그래프
		else if(value == "5"){
			var graph = '<div class="drag_stargraph" style="position:absolute; width:100px; left:'+x+'px; top:'+y+'px;">'
					  + '<img class="close" src="resources/img/close.png" width="20px" height="20px">'
					  + 	'<select id="stargraph'+graphNum+'">'
			  		  + 		'<option value="1">1</option>'
			  		  + 		'<option value="2">2</option>'
			  		  + 		'<option value="3">3</option>'
			  		  + 		'<option value="4">4</option>'
			  		  + 		'<option value="5">5</option>'
			  		  + 	'</select>'
			  		  + '</div>';
			  		  
			var id = $item.attr("id");
			
			$(graph).appendTo( $list ).fadeIn(function() {
				$item.animate({ width: "96px" })
				 .animate({ height: "72px" });
				
				
				if(id == "graph5_1"){
					$('#stargraph'+graphNum).barrating({
				        theme: 'bars-horizontal'
				      });
					$("#etc_graph ul").prepend('<li class="ui-widget-content ui-corner-tr" value="'+num+'" id="graph5_1">'
			    			 +'<h5 class="ui-widget-header">horizontal</h5>'
			  				 +'</li>'); 
				}
				else if(id == "graph5_2"){
					$('#stargraph'+graphNum).barrating({
						theme: 'bars-movie'
				      });
					$("#etc_graph li:nth-child(1)").after('<li class="ui-widget-content ui-corner-tr" value="'+num+'" id="graph5_2">'
			    			 +'<h5 class="ui-widget-header">movie</h5>'
			  				 +'</li>'); 
				}
				else if(id == "graph5_3"){
					$('#stargraph'+graphNum).barrating({
						theme: 'fontawesome-stars'
				      });
					$("#etc_graph li:nth-child(2)").after('<li class="ui-widget-content ui-corner-tr" value="'+num+'" id="graph5_3">'
			    			 +'<h5 class="ui-widget-header">star</h5>'
			  				 +'</li>'); 
				}
				
				
				
				
				
				
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

//이미지추가함수
function imgUpload() {
	
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
	
}