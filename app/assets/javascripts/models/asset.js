/*global Mopo, Backbone */
Mopo.Models.Asset = Backbone.Model.extend({
  urlRoot: '/assets',
  isAudio: function () {
    return this.get('type') === "Scrap::Audio";
  },
  isFile: function () {
    return this.get('type') === "Scrap::File";
  }
}, {
  backboneClass: "Asset"
});