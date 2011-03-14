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
        $("h3#month").fadeOut "slow", ->
            $(this).remove
        $("table").hide "slide", {direction: dirOut}, 480, ->
          $(this).replaceWith(newTable)
          $("table").show "slide", {direction: dirIn}, 300
    return false

  $("li a#sort_date").click ->
    fade_categories "date"

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
          $("ul#categories").html(newList)
          $("ul#categories").fadeIn "slow"
    return false

  $("#rando a").click ->
    count = this.getAttribute("data-message")
    random = Math.floor(Math.random() * count + 1)
    window.location = "/events/" + random
