/*global Mopo, Backbone */
Mopo.Collections.Likes = Backbone.Collection.extend({
  model: Mopo.Models.Like,
  url: '/likes'
});
