/*jslint nomen: true */
/*global Mopo, Backbone, _, jQuery */
Mopo.Views.FormErrors = Backbone.View.extend({
  initialize: function (options) {
    this.attributesWithErrors = this.options.attributesWithErrors;
  },

  render: function () {
    this.clearOldErrors();
    this.renderErrors();
  },

  clearOldErrors: function () {
    this.$(".field_with_errors").removeClass("field_with_errors");
    this.$(".help-inline").remove();
  },

  renderErrors: function () {
    _.each(this.attributesWithErrors, this.renderError, this);
  },

  renderError: function (errors, attribute) {
    var errorString = errors.join(", "),
      field = this.fieldFor(attribute),
      errorTag = jQuery('<span>').addClass('help-inline').text(errorString);

    field.append(errorTag);
    field.addClass("field_with_errors");
  },

  fieldFor: function (attribute) {
    return this.$('[id*="_' + attribute + '"]').closest(".field");
  }
});