$( function() {
  $('#assembly_duration_other').click( function(e) {
    if ($(this).hasClass('checked')) {
      $(this).removeClass('checked')
      $('#duration_text_div').hide();
    } else {
      $(this).addClass('checked')
      $('#duration_text_div').show();
    }
  });

  if (!($('#assembly_duration_other').hasClass('checked'))) {
    $('#duration_text_div').hide();
  }
});
