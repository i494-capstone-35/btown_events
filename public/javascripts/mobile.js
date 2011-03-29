(function() {
  $(document).ready(function() {
    /* m = parseInt $("#main")[0].getAttribute("data-message") */;    var m, move;
    m = 0;
    $("a#m_previous").click(function() {
      return move(-1);
    });
    $("a#m_next").click(function() {
      return move(1);
    });
    return move = function(direction) {
      m += direction;
      console.log(m);
      return $.ajax({
        url: '/date',
        data: {
          "date": m
        }
      });
    };
  });
}).call(this);
