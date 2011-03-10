$(document).ready ->
  m = 0

  $("#previous a").click ->
    slide "right", "left", -1

  $("#next a").click ->
    slide "left", "right", 1

  slide = (dirOut, dirIn, marker) ->
    m += marker 
    $.ajax
      url: '/increment'
      data: {"weeks" : m}
      success: (new_table) ->
        $("table").hide "slide", {direction: dirOut}, 480, ->
          $(this).replaceWith(new_table)
          $("table").show "slide", {direction: dirIn}, 300
    return false

  $("#rando a").click ->
    count = this.getAttribute("data-message")
    random = Math.floor(Math.random() * count + 1)
    window.location = "/events/" + random
