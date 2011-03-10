(function() {
  $(document).ready(function() {
    var m;
    m = 0;
    $("#previous a").click(function() {
      m -= 1;
      $.ajax({
        url: '/increment',
        data: {
          "weeks": m
        },
        success: function(new_table) {
          return $("table").hide("slide", {
            direction: "right"
          }, 480, function() {
            $(this).replaceWith(new_table);
            return $("table").show("slide", {
              direction: "left"
            }, 300);
          });
        }
      });
      return false;
    });
    $("#next a").click(function() {
      m += 1;
      $.ajax({
        url: '/increment',
        data: {
          "weeks": m
        },
        success: function(new_table) {
          return $("table").hide("slide", {
            direction: "left"
          }, 480, function() {
            $(this).replaceWith(new_table);
            return $("table").show("slide", {
              direction: "right"
            }, 300);
          });
        }
      });
      return false;
    });
    return $("#rando a").click(function() {
      var count, random;
      count = this.getAttribute("data-message");
      random = Math.floor(Math.random() * count + 1);
      return window.location = "/events/" + random;
    });
  });
}).call(this);
