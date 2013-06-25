/*global jQuery, document, Mopo, window */
(function ($) {
  $(document).on('pageinit', '.page', function (e) {

    var $page = $(e.currentTarget);

    $(window).off('scroll.pagination');

    //endless pagination
    if ($('.pagination', $page).length) {
      $(window).on('scroll.pagination', function () {
        var url = $('.pagination', $page).find('.next_page').attr('href');

        if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 200) {
          $('.pagination', $page).html($('<div class="spinner"><i class="icon-spinner icon-spin icon-2x"></i></div>'));
          $.getScript(url);
        }
      });
    }

  });
}(jQuery));