<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>jQuery UI Resizable - Default functionality</title>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <style>
  #resizable { width: 300px; height: 300px; padding: 0.5em; }
  #resizable h3 { text-align: center; margin: 0; }
  </style>
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  
  <!-- 이미지자르기 -->
  <link rel="stylesheet" type="text/css" href="resources/css/imgareaselect-default.css" />
  <script type="text/javascript" src="resources/scripts/jquery.imgareaselect.pack.js"></script>
  <!-- 여기까지 -->
  
  <script>
  $(document).ready(function() {
    $( "#resizable" ).resizable();
    $('img#photo').imgAreaSelect({
        handles: true,
        onSelectEnd: someFunction
    });
  } );
  </script>
  
  
</head>
<body>
 
	<img src="resources/img/ebphone.jpg" width="150px" height="150px" id="resizable"><br>
 	<img src="resources/img/ebphone.jpg" id="photo">
 
</body>
</html>