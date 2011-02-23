$(document).ready(function() {
  $("#next_month a").click(function() {
    $.ajax({url: '/increment?weeks=1'}); 
    return false;
  });
});
