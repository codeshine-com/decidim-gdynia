
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
