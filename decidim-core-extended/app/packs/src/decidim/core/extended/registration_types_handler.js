$( function() {
  // view fix
  if ( $('#registration-type-toggler').length > 0 ) {
    $('#registration-type-toggler').click( function(e) {
      e.preventDefault();
      let new_text = $('#inhabitant-register-form').hasClass('do-not-show') ? $(this).data('show-default') : $(this).data('show-inhabitant');
      $('#inhabitant-register-form').toggleClass('do-not-show');
      $('#register-form').toggleClass('do-not-show');
      $(this).text(new_text);
    });
  }
});
