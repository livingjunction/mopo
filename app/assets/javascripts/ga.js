/*global jQuery, document, ga */
//track view pages in google analytics
(function ($) {
  $(document).on('pageshow', '.page', function (e) {
    try {
      ga('send', 'pageview');
    } catch (err) {}
  });
}(jQuery));