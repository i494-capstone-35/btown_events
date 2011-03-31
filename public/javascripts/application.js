(function() {
  $(document).ready(function() {
    var fade_categories, highlightCategories, m, slide, url;
    m = 0;
    url = location.pathname.split('/')[1];
    highlightCategories = function() {
      var path;
      path = $("#sitemap li").filter(function() {
        return $(this).text().toLowerCase().indexOf(url) !== -1;
      });
      $(path).find("a").css({
        color: "white"
      });
      return $(path).css({
        color: "black",
        padding: "7px 13px",
        'margin-right': "15px",
        background: "#CC0000",
        '-webkit-border-radius': "8px",
        '-moz-border-radius': "8px",
        'border-radius': "8px"
      });
    };
    if (url !== '') {
      highlightCategories(url);
    }
    $("#previous a").click(function() {
      return slide("right", "left", -1);
    });
    $("#next a").click(function() {
      return slide("left", "right", 1);
    });
    slide = function(dirOut, dirIn, marker) {
      m += marker;
      $.ajax({
        url: '/increment',
        data: {
          "weeks": m
        },
        success: function(newTable) {
          /*$(newTable) is [<div>,ajaxytext,<table>]*/;          var month, table;
          month = $(newTable)[0];
          table = $(newTable)[2];
          $("p#month").fadeOut("slow", function() {
            $("p#month").html(month).addClass("n_month");
            return $("p#month").fadeIn("slow");
          });
          return $("table").hide("slide", {
            direction: dirOut
          }, 480, function() {
            $(this).replaceWith(table);
            return $("table").show("slide", {
              direction: dirIn
            }, 300, function() {
              return $("#rando a").animate({
                opacity: 0
              }, "fast");
            });
          });
        }
      });
      return false;
    };
    $("li a#sort_date").click(function() {
      return fade_categories("start_time");
    });
    $("li a#sort_name").click(function() {
      return fade_categories("name");
    });
    fade_categories = function(sortMethod) {
      var category;
      url = location.pathname;
      category = url.split('/')[2];
      $.ajax({
        url: '/sort',
        data: {
          "sortMethod": sortMethod,
          "category": category
        }
      });
      ({
        success: function(newList) {
          $("ul#categories").fadeOut("slow", function() {});
          $(this).html(newList);
          return $(this).fadeIn("slow");
        }
      });
      return false;
    };
    return $("#rando a").click(function() {
      var count, random;
      count = this.getAttribute("data-message");
      random = Math.floor(Math.random() * count + 1);
      return window.location = "/events/" + random;
    });
  });
}).call(this);
