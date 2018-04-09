/**
 * 
 */
document.execCommand('styleWithCSS', false, true);

document.execCommand('insertBrOnReturn', false, true);

  $(document).ready(function() {

    $("#text").focus();

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



  });
