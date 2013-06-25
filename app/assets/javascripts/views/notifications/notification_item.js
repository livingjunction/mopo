/*global Mopo, Support, JST, jQuery */
Mopo.Views.NotificationItem = Support.CompositeView.extend({
  template: JST['notifications/list_item'],

  events: {
    "click a": "markRead"
  },

  initialize: function () {
    this.bindTo(this.model, "change", this.render);
  },

  render: function () {
    this.setElement(this.template());
    this.$el.find('a').html(this.getPartialTemplate());

    if (this.model.isRead()) {
      this.$el.addClass("read");
    } else {
      this.$el.removeClass("read");
    }
    return this;
  },

  getPartialTemplate: function () {
    return JST[this.getPartialTemplateName()]({
      activity: this.model.get('activity')
    });
  },

  getPartialTemplateName: function () {
    return "notifications/_" + this.model.get('activity').trackable_type;
  },

  markRead: function (e) {
    e.preventDefault();

    var self = this;

    this.model.save({
      is_read: true
    }, {
      wait: true,
      success: function () {
        var url = self.getScrapUrl();
        if (url) {
          jQuery.mobile.changePage(url);
        }
      }
    });
  },

  getScrapUrl: function () {
    if (this.model.get('activity').trackable) {
      return new Mopo.Models.Scrap({
        id: this.model.get('activity').trackable.scrap_id
      }).url();
    }
  }
});