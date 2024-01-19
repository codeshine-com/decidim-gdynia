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

$(document).ready(function () {

  if ($('#inline-filter-sort').length > 0) {
    $('body').on('click', $(this), function(e) {
      if ($('#inline-filter-sort').hasClass('is-open')) {
        $('#inline-filter-sort').removeClass('is-open');
        $('#inline-filter-sort').attr('aria-hidden', true);
      }
    });
  }
});
