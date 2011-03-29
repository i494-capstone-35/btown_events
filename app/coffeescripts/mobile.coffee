$(document).ready ->
    /* m = parseInt $("#main")[0].getAttribute("data-message") */
    m = 0

    $("a#m_previous").click ->
        move -1

    $("a#m_next").click ->
        move 1

    move = (direction) ->
        m += direction
        console.log m
        $.ajax
            url: '/date'
            data: {"date" : m}

