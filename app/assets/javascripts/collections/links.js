/*global Mopo, Backbone */
Mopo.Collections.Links = Backbone.Collection.extend({
  model: Mopo.Models.Link,
  url: '/links'
});
