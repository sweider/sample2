# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/



jQuery(document).ready ->
  $("#micropost_content").on "keyup", ->
    symbs_left = 140 - $(this).val().length
    symbs_left = (if symbs_left >= 0 then symbs_left else 0)
    symbs = $("#symbs")
    if symbs.length is 0
      symbs_left_node = $("<p id='message' class='green'> <span id='symbs'>" + symbs_left + "</span> symbs left</p>")
      $(".field").append symbs_left_node
    else
      symbs.text symbs_left
      if symbs_left is 140
        $("#message").remove()
      else
        if symbs_left is 0
          $(this).val $(this).val().substr(0, 140)
          $("#message").toggleClass "green", false
          $("#message").toggleClass "yellow", false
          $("#message").toggleClass "red", true
        else
          if symbs_left <= 50
            $("#message").toggleClass "green", false
            $("#message").toggleClass "yellow", true
            $("#message").toggleClass "red", false
          else
            $("#message").toggleClass "green", true
            $("#message").toggleClass "yellow", false
            $("#message").toggleClass "red", false
