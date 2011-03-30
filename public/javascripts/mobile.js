(function() {
  $(document).ready(function() {
    var m, move;
    m = parseInt($("#main")[0].getAttribute("data-message"));
    $("a#m_previous").click(function() {
      return move(-1, true);
    });
    $("a#m_next").click(function() {
      return move(1, false);
    });
    return move = function(direction, slide) {
      m += direction;
      return $("body").load('/?date=' + m, $.mobile.changePage('/?date=' + m, "slide", slide, false, false));
    };
  });
}).call(this);
