$(document).ready ->
    url = location.pathname.split('/')
    m   = 0
    
    highlightCategories = ->
        path = $("#sitemap li").filter ->
            $(this).text().toLowerCase().indexOf(url) != -1
        $(path).find("a").css {
            color: "white"
        }
        $(path).css {
            color                   : "black"
            background              : "#CC0000"
            padding                 : "2px 10px"
            '-webkit-border-radius' : "8px"
            '-moz-border-radius'    : "8px"
            'border-radius'         : "8px"
        }
    if(url != '')
        highlightCategories(url)

    /* month navigation */
    $("#prev_month a").click ->
        calendarChange "right", "left", -1, -1

    $("#next_month a").click ->
        calendarChange "left", "right", 1, 1

    /* week navigation */
    $("#previous a").click ->
        calendarChange "right", "left", -1, 0

    $("#next a").click ->
        calendarChange "left", "right", 1, 0

    calendarChange = (dirOut, dirIn, newValue, newMonth) ->
        if newMonth != 0
            m     = parseInt($("table")[0].getAttribute("data-message"))
            month = newMonth
        else
            m = parseInt($("table")[0].getAttribute("data-message")) + newValue

        if newMonth == 0
            $(".date").each ->
                switch this.getAttribute("data-message")
                    when "next"
                        if newValue == 1
                            return newMonth = 1
                    when "prev"
                        if newValue == -1
                            return newMonth = -1

        if $("p#category").length == 1
            category = $("p#category")[0].innerHTML
            path = '/cat_increment'
        else
            path = 'increment'

        $.ajax
            url: path
            data: {
                "weeks"    : m
                "month"    : month
                "category" : category
                }
            dataType: "html"
            success: (newTable) ->
                if newMonth != 0
                    $("p#month").hide "slide", {direction: dirOut}, 600, ->
                        $(this).replaceWith($(newTable).find("p#month")[0])
                        $("p#month").show "slide", {direction: dirIn}, 200

                $("table").hide "slide", {direction: dirOut}, 480, ->
                    $(this).replaceWith($(newTable).find("table"))
                    $("table").show "slide", {direction: dirIn}, 300

        return false

