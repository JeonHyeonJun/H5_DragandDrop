<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>jQuery UI Droppable - Simple photo manager</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src="resources/js/jquery-3.2.1.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<link rel="stylesheet" type="text/css" href="resources/dataTables/DataTables-1.10.16/css/dataTables.jqueryui.css"/>
<link rel="stylesheet" type="text/css" href="resources/dataTables/ColReorder-1.4.1/css/colReorder.jqueryui.css"/>
<link rel="stylesheet" type="text/css" href="resources/dataTables/RowReorder-1.2.3/css/rowReorder.jqueryui.css"/>
<link rel="stylesheet" type="text/css" href="resources/dataTables/Select-1.2.5/css/select.jqueryui.css"/>
<link rel="stylesheet" type="text/css" href="resources/dataTables/datatables.css">

<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/jqc-1.12.3/dt-1.10.16/b-1.5.1/sl-1.2.5/datatables.min.css"/>
<link rel="stylesheet" type="text/css" href="resources/Editor-1.7.3/css/editor.dataTables.css">
<script type="text/javascript" src="https://cdn.datatables.net/v/dt/jqc-1.12.3/dt-1.10.16/b-1.5.1/sl-1.2.5/datatables.min.js"></script>
<script type="text/javascript" src="resources/Editor-1.7.3/js/dataTables.editor.js"></script>

<script type="text/javascript" charset="utf8" src="resources/dataTables/datatables.js"></script>
<script type="text/javascript" src="resources/dataTables/DataTables-1.10.16/js/jquery.dataTables.js"></script>
<script type="text/javascript" src="resources/dataTables/DataTables-1.10.16/js/dataTables.jqueryui.js"></script>
<script type="text/javascript" src="resources/dataTables/ColReorder-1.4.1/js/dataTables.colReorder.js"></script>
<script type="text/javascript" src="resources/dataTables/RowReorder-1.2.3/js/dataTables.rowReorder.js"></script>
<script type="text/javascript" src="resources/dataTables/Select-1.2.5/js/dataTables.select.js"></script>

  <style>
  #gallery { float: left; width: 65%; min-height: 12em; }
  .gallery.custom-state-active { background: #eee; }
  .gallery li { float: left; width: 96px; padding: 0.4em; margin: 0 0.4em 0.4em 0; text-align: center; }
  .gallery li h5 { margin: 0 0 0.4em; cursor: move; }
  .gallery li a { float: right; }
  .gallery li a.ui-icon-zoomin { float: left; }
  .gallery li img { width: 100%; height: 100%; cursor: move; }
 
  #trash { float: left; width: 32%; min-height: 18em; padding: 1%; }
  #trash h4 { line-height: 16px; margin: 0 0 0.4em; }
  #trash h4 .ui-icon { float: left; }
  #trash .gallery h5 { display: none; }
  
  .wrap {
      width: 50%;
    }
    .wrap textarea {
      width: 90%;
      resize: none;
      overflow-y: hidden; /* prevents scroll bar flash */
      padding: 1.1em; /* prevents text jump on Enter keypress */
      padding-bottom: 0.2em;
      line-height: 1.6;
      border:1;
      overflow:visible;
      text-overflow:ellipsis;
    }
  
  </style>
  <script>
  $( function() {
	 var $ttd = $('#ttd').DataTable();
	 

	 var editor = new $('#tdiv').dataTable.Editor( {} );
	 new $('#tdiv').dataTable.Editor( {
	    table: '#ttd',
	    fields: [
	        { label: 'First name', name: 'first_name' },
	        { label: 'Last name',  name: 'last_name'  },
	    ]
	} );
	 
	 $ttd.DataTable( {
		    columns: [
		        { data: 'first_name' },
		        { data: 'last_name' },
		    ],
		    select: true,
		    buttons: [
		        { extend: 'create', editor: editor },
		        { extend: 'edit',   editor: editor },
		        { extend: 'remove', editor: editor }
		    ]
		} );
	 
    // There's the gallery and the trash
	var $gallery = $( "#gallery" ),
	$trash = $( "#trash" );
 	
    $trash.resizable();
    
    // Let the gallery items be draggable
    $( "li", $gallery ).draggable({
		cancel: "a.ui-icon", // clicking an icon won't initiate dragging
		revert: "invalid", // when not dropped, the item will revert back to its initial position
		containment: "document",
		helper: "clone",
		cursor: "move"
    });
 
    $( "li", $gallery ).resizable({
    	containment: "#trash"
    });
    
    
    // Let the trash be droppable, accepting the gallery items
    $trash.droppable({
		accept: "#gallery > li",
		classes: {
        	"ui-droppable-active": "ui-state-highlight"
      	},
      	drop: function( event, ui ) {
        	deleteImage( ui.draggable );
      	}
    });
 
    // Let the gallery be droppable as well, accepting items from the trash
    $gallery.droppable({
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
    function deleteImage( $item ) {
		$item.fadeOut(function() {
	        var $list = $( "ul", $trash ).length ?
				$( "ul", $trash ) :
				$( "<ul class='gallery ui-helper-reset'/>" ).appendTo( $trash );
	 		
			var value = $item.val();
			if(value == "1"){
				var text = "<div class='wrap'>123<textarea class='textbox'></textarea></div>";
				$(text).appendTo( $list ).fadeIn(function() {
					$item.animate({ width: "96px" })
						 .animate({ height: "72px" });
					
					$( ".wrap").resizable({
	        	    	containment: "#trash",
	        	    	grid: [1, 10000]
	        	    });
					
					$('.wrap').on( 'keyup', 'textarea', function (e){
						$(this).css('height', 'auto' );
	        	        $(this).height( this.scrollHeight );
					});
					
					$('.wrap').find( 'textarea' ).keyup();
					
					$("#gallery").prepend('<li class="ui-widget-content ui-corner-tr" value="1">'
			    			 +'<h5 class="ui-widget-header">TextBox</h5>'
			    			 +'<img src="resources/img/icon_textbox.png" alt="The peaks of High Tatras" width="96" height="72">'
			  				 +'</li>');	
					
				});
			}
			else if(value == "2"){
				var table = "<table border='1' class='tables'><tr><td><input type='text'></td><td><input type='text'></td></tr>"
							+ "<tr><td><input type='text'></td><td><input type='text'></td></tr>"
							+ "<tr><td><input type='text'></td><td><input type='text'></td></tr></table>";
				$(table).appendTo( $list ).fadeIn(function() {
					$item.animate({ width: "96px" })
						 .animate({ height: "72px" });
					
					$( ".tables").resizable({
	        	    	containment: "#trash"
	        	    });
					
					
					$("#gallery").prepend('<li class="ui-widget-content ui-corner-tr" value="2">'
			    			 +'<h5 class="ui-widget-header">Table</h5>'
			    			 +'<img src="resources/img/icon_table.png" alt="The peaks of High Tatras" width="96" height="72">'
			  				 +'</li>');	
					
				});
			}
			else {
				$item.appendTo( $list ).fadeIn(function() {
	                  $item.animate({ width: "96px" })
	                       .animate({ height: "72px" });
				});
			}
	        
			$( "li", $gallery ).draggable({
				cancel: "a.ui-icon", // clicking an icon won't initiate dragging
				revert: "invalid", // when not dropped, the item will revert back to its initial position
				containment: "document",
				helper: "clone",
				cursor: "move"
		    });
			
			$("#tdiv").text($gallery.text());
		});
	}
 
    // Image recycle function
	var trash_icon = "<a href='link/to/trash/script/when/we/have/js/off' title='Delete this image' class='ui-icon ui-icon-trash'>Delete image</a>";
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
          .appendTo( $gallery )
          .fadeIn();
      });
    }
    
    
      
  } );
  </script>
  
</head>
<body>
 
<div class="ui-widget ui-helper-clearfix">
 
<div id="trash" class="ui-widget-content ui-state-default">
  <h4 class="ui-widget-header">なでなで</h4>
</div>

<ul id="gallery" class="gallery ui-helper-reset ui-helper-clearfix">
  <li class="ui-widget-content ui-corner-tr" value="1">
    <h5 class="ui-widget-header">TextBox</h5>
    <img src="resources/img/icon_textbox.png" width="96" height="72">
  </li>
  <li class="ui-widget-content ui-corner-tr" value="2">
    <h5 class="ui-widget-header">Table</h5>
    <img src="resources/img/icon_table.png" width="96" height="72">
  </li>
  <li class="ui-widget-content ui-corner-tr" value="3">
    <h5 class="ui-widget-header">이미지3</h5>
    <img src="resources/img/trashcan.jpg" alt="The chalet at the Green mountain lake" width="96" height="72">
  </li>
  <li class="ui-widget-content ui-corner-tr" value="4">
    <h5 class="ui-widget-header">이미지4</h5>
    <img src="resources/img/ebphone.jpg" alt="On top of Kozi kopka" width="96" height="72">
  </li>
</ul>
 

 
</div>
	<table id="ttd">
    	<thead>
        <tr>
            <th>Name</th>
            <th>Position</th>
            <th>Office</th>
            <th>Age</th>
            <th>Start date</th>
            <th>Salary</th>
        </tr>
        </thead>
        <tbody>
        <tr>
        	<td>1</td>
        	<td>2</td>
        	<td>3</td>
        	<td>4</td>
        	<td>5</td>
        	<td>6</td>
        </tr>
        <tr>
        	<td>1</td>
        	<td>2</td>
        	<td>3</td>
        	<td>4</td>
        	<td>5</td>
        	<td>6</td>
        </tr>
        </tbody>
    
</table>
	<div id="tdiv"></div>
</body>
</html>