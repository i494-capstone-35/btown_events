(function() {
  $(document).ready(function() {
    var fade_categories, highlightCategories, m, preload, slide, url;
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
          console.log(images);
          return preload(images);
        });
      }
    });
    m = 0;
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
    $("#previous a").click(function() {
      return slide("right", "left", -1);
    });
    $("#next a").click(function() {
      return slide("left", "right", 1);
    });
    slide = function(dirOut, dirIn, marker) {
      var category, path;
      if ($("p#category").length === 1) {
        category = $("p#category")[0].innerHTML;
      }
      m += marker;
      if ($("p#category").length === 1) {
        path = '/cat_increment';
      } else {
        path = 'increment';
      }
      $.ajax({
        url: path,
        data: {
          "weeks": m,
          "category": category
        },
        success: function(newTable) {
          /*$(newTable) == [<div>,ajaxytext,<table>]*/;          var month, table;
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
        },
        success: function(newList) {
          return $("ul#categories").fadeOut("slow", function() {
            $(this).html(newList);
            return $(this).fadeIn("slow");
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
