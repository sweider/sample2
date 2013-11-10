// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready(function(){
  $(".message-content").on("click", function(){
    var message_id = $(this).find(".hidden").text();
    var the_url = '/message_by_ajax/' + message_id;
    $.ajax({url: the_url});
  });


});


