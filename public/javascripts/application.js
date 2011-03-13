(function() {
  $(document).ready(function() {
    var fade_categories, m, slide;
    m = 0;
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
          return $("table").hide("slide", {
            direction: dirOut
          }, 480, function() {
            $(this).replaceWith(newTable);
            return $("table").show("slide", {
              direction: dirIn
            }, 300);
          });
        }
      });
      return false;
    };
    $("li a#sort_date").click(function() {
      return fade_categories("date");
    });
    $("li a#sort_name").click(function() {
      return fade_categories("name");
    });
    fade_categories = function(sortMethod) {
      var category, url;
      url = location.pathname;
      category = url.split('/')[2];
      $.ajax({
        url: '/sort',
        data: {
          "sortMethod": sortMethod,
          "category": category
        },
        success: function(newList) {
          return $("ul#categories").fadeOut("slow", function() {
            $("ul#categories").html(newList);
            return $("ul#categories").fadeIn("slow");
          });
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
