/*global Mopo, Support, JST */
Mopo.Views.CommentsList = Support.CompositeView.extend({
  template: JST['comments/list'],

  initialize: function () {
    this.scrap = this.options.scrap;
    this.bindTo(this.collection, "add", this.renderComment);
  },

  render: function () {
    this.renderTemplate();
    this.renderComments();
    this.renderCommentForm();
    this.rerenderJQM();
    return this;
  },

  renderTemplate: function () {
    this.$el.html(this.template());
  },

  renderComments: function () {
    this.getCommentsContainer().empty();

    this.collection.each(this.renderComment, this);
  },

  renderComment: function (comment) {
    var commentView = new Mopo.Views.CommentItem({
      model: comment
    });
    this.getCommentsContainer().append(commentView.render().el);
  },

  getCommentsContainer: function () {
    return this.$('.comments-list');
  },

  renderCommentForm: function () {
    if (Mopo.ability.can("create", Mopo.Models.Comment)) {
      var commentForm = new Mopo.Views.CommentForm({
        collection: this.collection,
        scrap: this.scrap
      });
      this.renderChildInto(commentForm, this.$('.new-comment-form'));
    }
  },

  rerenderJQM: function () {
    //let jquery mobile know to rerender
    this.$el.trigger('create');
  }
});