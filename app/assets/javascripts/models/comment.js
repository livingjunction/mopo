/*global Mopo, Backbone */
Mopo.Models.Comment = Backbone.Model.extend({
  urlRoot: '/comments'
}, {
  backboneClass: "Comment"
});