$(document).ready(function () {

  if ($('.cell.medium-3').length > 0 ) {
    setTimeout(function() {
      $('.cell.medium-3').each( function() {
        if ($(this).children('.areachart').length > 0 ) {
        } else {
          $(this).hide();
        }
      });
    }, 500);

  }

  if ($('.cell.medium-2').length > 0 ) {
    setTimeout(function() {
      $('.cell.medium-2').each( function() {
        if ($(this).children('.areachart').length > 0 ) {
        } else {
          $(this).hide();
        }
      });
    }, 500);
  }

  if ($('.promoted-scope').length > 0) {
    $('.promoted-scope').last().addClass('border');
  }
});
