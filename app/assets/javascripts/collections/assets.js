/*global Mopo, Backbone */
Mopo.Collections.Assets = Backbone.Collection.extend({
  model: Mopo.Models.Asset,
  url: '/assets'
});
