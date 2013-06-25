/*global Mopo, Support, JST */
Mopo.Views.LikeButton = Support.CompositeView.extend({

  template: JST['likes/button'],

  events: {
    "click #like-scrap": "toogleLike"
  },

  initialize: function () {
    this.user_id = this.options.user_id;
    this.scrap_id = this.options.scrap_id;
    this.collection = this.options.collection;
    this.processing = false;

    this.bindTo(this.collection, "add", this.render);
    this.bindTo(this.collection, "remove", this.render);
  },

  render: function () {
    var self = this,
      iconClass;

    this.liked = this.collection.find(function (like) {
      return like.get('user_id') === self.user_id && like.get('scrap_id') === self.scrap_id;
    });
    iconClass = this.liked ? 'liked' : '';
    this.$el.html(this.template({
      iconClass: iconClass
    }));
    return this;
  },

  toogleLike: function (e) {
    e.preventDefault();

    //prevent double clicking
    if (this.processing) {
      return false;
    } else {
      this.processing = true;

      if (this.liked) {
        this.unlike();
      } else {
        this.like();
      }
    }

  },

  unlike: function () {
    var self = this;

    this.liked.destroy({
      wait: true,
      success: function () {
        self.processing = false;
      }
    });
  },

  like: function () {
    var self = this,
      like = new Mopo.Models.Like({
        user_id: this.user_id,
        scrap_id: this.scrap_id
      });

    this.collection.create(like, {
      wait: true,
      success: function () {
        self.processing = false;
      }
    });
  }
});