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
// require rails-ujs
//= require activestorage
//= require_tree .

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
