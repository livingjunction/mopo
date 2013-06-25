/*jslint nomen: true */
/*global Mopo, Support, JST, _, $ */
Mopo.Views.CommentForm = Support.CompositeView.extend({

  template: JST['comments/new'],

  events: {
    "click button#add_comment": "createComment"
  },

  initialize: function () {
    this.scrap = this.options.scrap;
  },

  render: function () {
    this.renderTemplate();
    this.renderEmoticons();
    return this;
  },

  renderTemplate: function () {
    this.setElement(this.template());
  },

  renderEmoticons: function () {
    var self = this;

    this.$('#emoticonsPopup span').click(function (e) {
      // popup is inserted to div data=role=page
      $('#emoticonsPopup').popup("close");

      self.$el.find('#comment_body').insertAtCaret(
        $(this).text()
      );
    });
  },

  createComment: function (e) {
    e.preventDefault();
    var commentBody = this.$('#comment_body').val(),
      comment;

    if (_.str.isBlank(commentBody)) {
      return false;
    }

    comment = new Mopo.Models.Comment({
      body: commentBody,
      scrap_id: this.scrap.get('id')
    });
    this.$('#comment_body').val('');
    this.collection.create(comment, {
      wait: true
    });
  }
});