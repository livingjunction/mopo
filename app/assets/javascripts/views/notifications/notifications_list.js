/*global Mopo, Support, JST*/
Mopo.Views.NotificationsList = Support.CompositeView.extend({

  initialize: function () {
    this.collection = new Mopo.Collections.Notifications();
  },

  render: function () {
    var self = this;

    //reset event was not triggered correctly
    this.collection.fetch({
      success: function () {
        self.renderNotifications();
      }
    });
    return this;
  },

  renderNotifications: function () {
    var self = this;

    self.$el.empty().append(JST["notifications/header"]());

    this.collection.each(function (notification) {
      var notificationView = new Mopo.Views.NotificationItem({
        model: notification
      });
      self.$el.append(notificationView.render().el);
    });

    self.$el.data('mopo-rendered', true).listview("refresh");
  }
});