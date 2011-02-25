$(document).ready(function() {
  var m = 0;
  $("#previous_month a").click(function() {
    m -= 1;
    $.ajax({
      url: '/increment',
      data: 'weeks=' + m,
      success: function(new_table) {
        $("table").fadeOut("slow", function() {
          $(this).replaceWith(new_table).fadeIn("fast");
        });
      }
    }); 
    return false;
  });
  $("#next_month a").click(function() {
    m += 1;
    $("table").fadeOut("slow");
    $.ajax({
      url: '/increment',
      data: 'weeks=' + m,
      success: function(new_table) {
        $("table").fadeOut("slow", function() {
          $(this).replaceWith(new_table).fadeIn("fast");
        });
      }
    }); 
    return false;
  });
});
