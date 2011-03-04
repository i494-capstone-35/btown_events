$(document).ready(function() {
  // For advancing / reversing days 
  var m = 0;
  $("#previous_month a").click(function() {
    m -= 1;
    $.ajax({
      url: '/increment',
      data: {"weeks":m},
      success: function(new_table) {
        $("table").hide("slide", {direction: "right"}, 480, function() {
          $(this).replaceWith(new_table);
          $("table").show("slide", {direction: "left"}, 300);
        });
      }
    }); 
    return false;
  });
  $("#next_month a").click(function() {
    m += 1;
    $.ajax({
      url: '/increment',
      data: {"weeks":m},
      success: function(new_table) {
        $("table").hide("slide", {direction: "left"}, 480, function() {
          $(this).replaceWith(new_table);
          $("table").show("slide", {direction: "right"}, 300);
        });
      }
    }); 
    return false;
  });

  // For generating a random number
  $("#rando a").click(function() {
    var count = this.getAttribute("data-message");
    var random = Math.floor(Math.random()*count + 1);
    console.log(random);
    window.location = "/events/" + random;
  });
});
