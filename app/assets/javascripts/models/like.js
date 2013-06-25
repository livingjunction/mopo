/*global Mopo, Backbone */
Mopo.Models.Like = Backbone.Model.extend({
  urlRoot: '/likes'
}, {
  backboneClass: "Like"
});