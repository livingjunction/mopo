/*global Mopo, Support, JST  */
Mopo.Views.AssetItem = Support.CompositeView.extend({

  template: JST['assets/item'],

  events: {
    "click .delete-asset": "deleteAsset"
  },

  initialize: function (options) {
    this.bindTo(this.model, 'destroy', this.remove);
  },

  render: function () {
    this.setElement(this.template({
      asset: this.model
    }));
    return this;
  },

  deleteAsset: function (e) {
    e.preventDefault();

    var self = this,
      popup = new Mopo.Views.ConfirmationPopup();

    this.bindTo(popup, 'confirmation:accept.mopo', function () {
      self.model.destroy();
    });
    popup.render();
  }
});