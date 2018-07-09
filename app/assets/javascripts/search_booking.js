$(document).ready(function(){
  $('#search-box').change(function(){
    $.ajax({
      method: 'get',
      url: '/booking_tickets',
      data: {customer_id: $('#search-box').val()},
      contentType: 'json',
      dataType: 'script'
    });
  });
});
