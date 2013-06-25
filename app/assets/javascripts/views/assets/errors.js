/*jslint nomen: true */
/*global Mopo, Backbone, _, jQuery */
Mopo.Views.AssetErrors = Backbone.View.extend({
  className: "asset-errors",

  initialize: function (options) {
    this.attributesWithErrors = this.options.attributesWithErrors;
  },

  render: function () {
    this.renderErrors();
    return this;
  },

  renderErrors: function () {
    _.each(this.attributesWithErrors, this.renderError, this);
  },

  renderError: function (errors, attribute) {
    var errorString = errors.join(", "),
      errorTag = jQuery('<div>').text(errorString);

    this.$el.append(errorTag);
  }
});