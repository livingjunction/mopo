/*global Mopo, Backbone */
Mopo.Collections.Comments = Backbone.Collection.extend({
  model: Mopo.Models.Comment,
  url: '/comments'
});
