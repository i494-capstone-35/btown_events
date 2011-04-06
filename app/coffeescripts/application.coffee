$(document).ready ->
    m = 0

    url = location.pathname.split('/')[1]
    highlightCategories = ->
        path = $("#sitemap li").filter ->
            $(this).text().toLowerCase().indexOf(url) != -1
        $(path).find("a").css {
            color: "white"
        }
        $(path).css {
            color: "black"
            padding: "7px 13px"
            'margin-right': "15px"
            background: "#CC0000"
            '-webkit-border-radius': "8px"
            '-moz-border-radius': "8px"
            'border-radius': "8px"
        }
    if(url != '')
        highlightCategories(url)

    $("#previous a").click ->
        slide("right", "left", -1)

    $("#next a").click ->
        slide("left", "right", 1)

    slide = (dirOut, dirIn, marker) ->
        m += marker
        $.ajax
            url: '/increment'
            data: {"weeks" : m}
            success: (newTable) ->
                /*$(newTable) == [<div>,ajaxytext,<table>]*/
                month = $(newTable)[0]
                table = $(newTable)[2]
                $("p#month").fadeOut "slow", ->
                    # replace html to fadeIn properly. add class to remove margin
                    $("p#month").html(month).addClass("n_month")
                    $("p#month").fadeIn("slow")
                $("table").hide "slide", {direction: dirOut}, 480, ->
                    $(this).replaceWith(table)
                    $("table").show "slide", {direction: dirIn}, 300, ->
                        $("#rando a").animate({ opacity: 0 }, "fast")
        return false

    $("li a#sort_date").click ->
        fade_categories("start_time")

    $("li a#sort_name").click ->
        fade_categories("name")

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
                    $(this).fadeIn("slow")
        return false

    $("#rando a").click ->
        count = this.getAttribute("data-message")
        random = Math.floor(Math.random() * count + 1)
        window.location = "/events/" + random

