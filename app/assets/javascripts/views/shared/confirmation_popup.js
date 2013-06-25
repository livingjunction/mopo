/*global Mopo, Support, JST, I18n, jQuery */
Mopo.Views.ConfirmationPopup = Support.CompositeView.extend({

  template: JST['shared/confirmation_popup'],

  events: {
    "click .confirmation-popup-accept": "confirmationAccept"
  },

  initialize: function () {
    this.title = this.options.title || I18n.t('shared.confirmation');
    this.accept = this.options.accept || I18n.t('shared.accept');
    this.cancel = this.options.cancel || I18n.t('shared.cancel');
  },

  render: function () {
    this.setElement(this.template({
      title: this.title,
      accept: this.accept,
      cancel: this.cancel
    }));
    jQuery.mobile.activePage.append(this.$el).trigger("pagecreate");
    this.$el.popup('open');
    return this;
  },

  confirmationAccept: function (e) {
    e.preventDefault();
    this.trigger('confirmation:accept.mopo');
    this.remove();
  }

});