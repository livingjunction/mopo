/*jslint nomen: true */
/*global Mopo, Support, JST, _ */
Mopo.Views.LinkItem = Support.CompositeView.extend({

  template: JST['links/item'],

  events: {
    "click .delete-link": "deleteLink"
  },

  initialize: function (options) {
    this.bindTo(this.model, 'destroy', this.remove);
  },

  render: function () {
    this.setElement(this.template({
      link: this.model
    }));
    return this;
  },

  deleteLink: function (e) {
    e.preventDefault();

    var self = this,
      popup = new Mopo.Views.ConfirmationPopup();

    this.bindTo(popup, 'confirmation:accept.mopo', function () {
      self.model.destroy();
    });
    popup.render();
  }
});