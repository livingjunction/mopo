/*global Mopo, Support, JST */
Mopo.Views.CommentItem = Support.CompositeView.extend({
  className: "media",

  template: JST['comments/show'],

  events: {
    "click .delete-comment": "deleteComment"
  },

  initialize: function (options) {
    this.bindTo(this.model, 'destroy', this.remove);
  },

  render: function () {
    this.$el.html(this.template({
      comment: this.model
    }));
    this.$('.media-content').emoticonize();
    return this;
  },

  deleteComment: function (e) {
    e.preventDefault();

    var self = this,
      popup = new Mopo.Views.ConfirmationPopup();

    this.bindTo(popup, 'confirmation:accept.mopo', function () {
      self.model.destroy();
    });
    popup.render();
  }
});