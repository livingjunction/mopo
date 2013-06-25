/*global Mopo, Backbone */
Mopo.Models.Notification = Backbone.Model.extend({
  urlRoot: '/notifications',
  isRead: function () {
    return this.get('is_read');
  }
}, {
  backboneClass: "Notification"
});