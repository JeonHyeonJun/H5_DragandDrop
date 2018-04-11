<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style type="text/css">
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
</style>
<script type="text/javascript" src="resources/js/jquery-3.2.1.js"></script>
<script type="text/javascript">
	$(function() {
		$('#see').html('${html}');
	});
</script>
</head>
<body>
	<h1>저장된 포트폴리오</h1>
	<hr>
	<div id="see"></div>	
</body>
</html>