/*global jQuery, document, Mopo */
(function ($) {
  $(document).on('pageinit', '.page', function (e) {

    var $page = $(e.currentTarget),
      $notifications = $('#notifications', $page);

    $('.user-notifications-link').click(function () {
      //render only once
      if (!$notifications.data('mopo-rendered')) {
        new Mopo.Views.NotificationsList({
          el: $notifications
        }).render();
      }
    });
  });
}(jQuery));