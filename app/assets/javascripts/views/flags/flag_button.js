/*global Mopo, Support, JST */
Mopo.Views.FlagButton = Support.CompositeView.extend({

  template: JST['flags/button'],

  events: {
    "click .scrap-flag-green": "flagGreen",
    "click .scrap-flag-red": "flagRed",
    "click .scrap-flag-yellow": "flagYellow"
  },

  initialize: function () {
    this.bindTo(this.model, "change", this.render);
  },

  render: function () {
    this.renderTemplate();
    this.renderColor();
    return this;
  },

  renderTemplate: function () {
    this.$el.html(this.template());
  },

  renderColor: function () {
    this.$('.scrap-flag').removeClass('selected');
    if (this.model.get('color')) {
      var className = "scrap-flag-" + this.model.get('color');
      this.$('.' + className).addClass('selected');
    }
  },

  flagGreen: function (e) {
    e.preventDefault();
    this.flag("green");
  },

  flagRed: function (e) {
    e.preventDefault();
    this.flag("red");
  },

  flagYellow: function (e) {
    e.preventDefault();
    this.flag("yellow");
  },

  flag: function (color) {
    if (!Mopo.ability.can("create", Mopo.Models.Flag)) {
      return;
    }
    if (color === this.model.get('color')) {
      color = null;
    }
    this.model.save({
      color: color
    });
  }
});