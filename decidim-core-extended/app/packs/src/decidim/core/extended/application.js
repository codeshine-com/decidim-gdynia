// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require_tree .

$( function() {
  if ( $('#register-form').length > 0 ) {
    // reload
    if ($('#registration_user_card_number_possesion').prop('checked')) {
      $('#registration_user_card_number').attr('disabled', null);
    } else {
      $('#registration_user_card_number').attr('disabled', 'true');
    }

    // event
    $('#registration_user_card_number_possesion').click( function(e) {
      if ($(this).prop('checked')) {
        $('#registration_user_card_number').attr('disabled', null);
      } else {
        $('#registration_user_card_number').attr('disabled', 'true');
      }
    });
  }
});


$( function() {
  // $('body').on('click', 'li', function(e) {
  //   console.log('cokolwiek');
  //   $('#user-conversations-add-modal').find('button[type="submit"]').addClass('disabled');
  //   $('#user-conversations-add-modal').find('button[type="submit"]').attr('disabled', 'true');
  // })

  if ($('#user-conversations-add-modal').length > 0) {
    // if ($('.js-multiple-mentions-recipients label').length == 0) {
    //   $('#user-conversations-add-modal').find('button[type="submit"]').addClass('disabled');
    //   $('#user-conversations-add-modal').find('button[type="submit"]').attr('disabled', 'true');
    // }

    $('body').on('mousedown', '#results li', function(e) {
      $('#user-conversations-add-modal').find('button[type="submit"]').removeClass('disabled');
      $('#user-conversations-add-modal').find('button[type="submit"]').attr('disabled', null);
    });

    $('body').on('mousedown', '.js-multiple-mentions-recipients label div', function(e) {
      setTimeout( function() {
        if ($('.js-multiple-mentions-recipients label').length > 0) {
          $('#user-conversations-add-modal').find('button[type="submit"]').removeClass('disabled');
          $('#user-conversations-add-modal').find('button[type="submit"]').attr('disabled', null);
        } else {
          $('#user-conversations-add-modal').find('button[type="submit"]').addClass('disabled');
          $('#user-conversations-add-modal').find('button[type="submit"]').attr('disabled', 'true');
        }
      }, 200);
    });
  }
});
