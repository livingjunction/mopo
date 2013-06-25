/*global Mopo, Support, JST, I18n */
Mopo.Views.Likes = Support.CompositeView.extend({
  template: JST['likes/summary'],

  initialize: function () {
    this.scrap = this.options.scrap;
    this.user_id = this.options.user_id;
    this.bindTo(this.collection, "add", this.renderLikes);
    this.bindTo(this.collection, "remove", this.renderLikes);
  },

  render: function () {
    this.renderTemplate();
    this.renderLikeButton();
    this.renderLikes();
    return this;
  },

  renderTemplate: function () {
    this.$el.html(this.template());
  },

  renderLikes: function () {
    this.$('.likes').html(
      I18n.t("shared.likes.counts", {
        count: this.collection.length
      })
    );
  },

  renderLikeButton: function () {
    if (Mopo.ability.can("create", Mopo.Models.Like)) {
      var likeButton = new Mopo.Views.LikeButton({
        collection: this.collection,
        scrap_id: this.scrap.get('id'),
        user_id: this.user_id
      });
      this.renderChildInto(likeButton, this.$('.like-button'));
    }
  }
});