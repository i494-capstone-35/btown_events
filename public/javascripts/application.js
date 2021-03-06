(function() {
  $(document).ready(function() {
    var calendarChange, highlightCategories, m, url;
    url = location.pathname.split('/');
    m = 0;
    highlightCategories = function() {
      var path;
      path = $("#sitemap li").filter(function() {
        return $(this).text().toLowerCase() === url[1];
      });
      $(path).find("a").css({
        color: "white"
      });
      return $(path).css({
        color: "black",
        background: "#CC0000",
        padding: "2px 10px",
        '-webkit-border-radius': "8px",
        '-moz-border-radius': "8px",
        'border-radius': "8px"
      });
    };
    if (url !== '') {
      highlightCategories(url);
    }
    $("#prev_month a").click(function() {
      return calendarChange("right", "left", -1, -1);
    });
    $("#next_month a").click(function() {
      return calendarChange("left", "right", 1, 1);
    });
    $("#previous a").click(function() {
      return calendarChange("right", "left", -1, 0);
    });
    $("#next a").click(function() {
      return calendarChange("left", "right", 1, 0);
    });
    return calendarChange = function(dirOut, dirIn, newValue, newMonth) {
      var category, month, path;
      if (newMonth !== 0) {
        m = parseInt($("table")[0].getAttribute("data-message"));
        month = newMonth;
      } else {
        m = parseInt($("table")[0].getAttribute("data-message")) + newValue;
      }
      if (newMonth === 0) {
        $(".date").each(function() {
          switch (this.getAttribute("data-message")) {
            case "next":
              if (newValue === 1) {
                return newMonth = 1;
              }
              break;
            case "prev":
              if (newValue === -1) {
                return newMonth = -1;
              }
          }
        });
      }
      if ($("p#category").length === 1) {
        category = $("p#category")[0].innerHTML;
        path = '/cat_increment';
      } else {
        path = 'increment';
      }
      $.ajax({
        url: path,
        data: {
          "weeks": m,
          "month": month,
          "category": category
        },
        dataType: "html",
        success: function(newTable) {
          if (newMonth !== 0) {
            $("p#month").hide("slide", {
              direction: dirOut
            }, 600, function() {
              $(this).replaceWith($(newTable).find("p#month")[0]);
              return $("p#month").show("slide", {
                direction: dirIn
              }, 200);
            });
          }
          return $("table").hide("slide", {
            direction: dirOut
          }, 480, function() {
            $(this).replaceWith($(newTable).find("table"));
            return $("table").show("slide", {
              direction: dirIn
            }, 300);
          });
        }
      });
      return false;
    };
  });
}).call(this);
