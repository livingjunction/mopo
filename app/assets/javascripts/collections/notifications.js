/*global Mopo, Backbone */
Mopo.Collections.Notifications = Backbone.Collection.extend({
  model: Mopo.Models.Notification,
  url: '/notifications'
});
