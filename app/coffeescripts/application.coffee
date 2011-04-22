$(document).ready ->
    url = location.pathname.split('/')
    
    preload = (arrayOfImages) -> 
        $(arrayOfImages).each ->
            $('<img/>')[0].src = this;

    $(window).load ->
        /* if url is '\/places' or '\/categories' */
        if (url[1] == 'places' or url[1] == 'categories') and url.length == 2
            $.getJSON url[1] + '_images', (images) ->
                switch url[1]
                    when 'places' then $(images).each (i) ->
                        images[i] = "images/logos/" + images[i] + ".png"
                    when 'categories' then $(images).each (i) ->
                        images[i] = "images/categories/" + images[i] + ".png"
                preload(images)

    m = 0

    highlightCategories = ->
        path = $("#sitemap li").filter ->
            $(this).text().toLowerCase().indexOf(url) != -1
        $(path).find("a").css {
            color: "white"
        }
        $(path).css {
            color: "black"
            background: "#CC0000"
            padding: "2px 10px"
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
        if $("p#category").length == 1
            category = $("p#category")[0].innerHTML
        m += marker
        # category page contains a data-message
        if $("p#category").length == 1
            path = '/cat_increment'
        else
            path = 'increment'
        $.ajax
            url: path
            data: {
                "weeks" : m
                "category" : category
                }
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

