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
      success: (newTable) ->
        /*$(newTable) is [<div>,ajaxytext,<table>]*/
        month = $(newTable)[0]
        table = $(newTable)[2]
        $("p#month").fadeOut "slow", ->
            # replace html to fadeIn properly. add class to remove margin
            $("p#month").html(month).addClass("n_month")
            $("p#month").fadeIn "slow"
        $("table").hide "slide", {direction: dirOut}, 480, ->
            $(this).replaceWith table
            $("table").show "slide", {direction: dirIn}, 300, ->
                $("#rando a").animate { opacity: 0 }, "fast"
    return false

  $("li a#sort_date").click ->
    fade_categories "start_time"

  $("li a#sort_name").click ->
    fade_categories "name"

  fade_categories = (sortMethod) ->
    url = location.pathname
    category = url.split('/')[2]
    $.ajax
      url: '/sort'
      data: {
        "sortMethod" : sortMethod,
        "category"   : category
      }
      success: (newList) ->
        $("ul#categories").fadeOut "slow", ->
          $(this).html(newList)
          $(this).fadeIn "slow"
    return false

  $("#rando a").click ->
    count = this.getAttribute("data-message")
    random = Math.floor(Math.random() * count + 1)
    window.location = "/events/" + random
