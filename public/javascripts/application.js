(function() {
  $(document).ready(function() {
    var calendarChange, highlightCategories, m, preload, url;
    m = 0;
    url = location.pathname.split('/');
    preload = function(arrayOfImages) {
      return $(arrayOfImages).each(function() {
        return $('<img/>')[0].src = this;
      });
    };
    $(window).load(function() {
      /* if url is '\/places' or '\/categories' */;      if ((url[1] === 'places' || url[1] === 'categories') && url.length === 2) {
        return $.getJSON(url[1] + '_images', function(images) {
          switch (url[1]) {
            case 'places':
              $(images).each(function(i) {
                return images[i] = "images/logos/" + images[i] + ".png";
              });
              break;
            case 'categories':
              $(images).each(function(i) {
                return images[i] = "images/categories/" + images[i] + ".png";
              });
          }
          return preload(images);
        });
      }
    });
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
    /* month navigation */;
    $("#prev_month a").click(function() {
      return calendarChange("right", "left", -1, -1);
    });
    $("#next_month a").click(function() {
      return calendarChange("left", "right", 1, 1);
    });
    /* week navigation */;
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
            }, 480, function() {
              $(this).replaceWith($(newTable).find("p#month")[0]);
              return $("p#month").show("slide", {
                direction: dirIn
              }, 300);
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
