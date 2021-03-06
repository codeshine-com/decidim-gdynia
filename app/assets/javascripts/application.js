// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require decidim
//=require decidim/core/extended/application.js
//=require decidim/assemblies/extended/application.js
//= require_tree .

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
