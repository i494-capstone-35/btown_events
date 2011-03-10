(function() {
  $(document).ready(function() {
    var m, slide;
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
        success: function(new_table) {
          return $("table").hide("slide", {
            direction: dirOut
          }, 480, function() {
            $(this).replaceWith(new_table);
            return $("table").show("slide", {
              direction: dirIn
            }, 300);
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
