$(document).ready ->
    m = parseInt $("#main")[0].getAttribute("data-message")

    $("a#m_previous").click ->
        move -1, true

    $("a#m_next").click ->
        move 1, false

    move = (direction, slide) ->
        m += direction
        $("body").load '/?date=' + m,
            $.mobile.changePage '/?date=' + m, "slide", slide, false, false
