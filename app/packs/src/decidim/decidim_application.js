// This file is compiled inside Decidim core pack. Code can be added here and will be executed
// as part of that pack

// Load images
require.context("../../images", true)



$( function() {
  if ( $('.tooltip').length > 0 ) {
    $(document).keyup(function(e) {
      if (e.keyCode == 27) {
        //27 = keycode for escape
        $('.tooltip').each( function() {
          $(this).attr('aria-hidden', true);
          $(this).attr('data-is-active', false);
          $(this).css('display', 'none');
        });
      }
    });
  }
});
