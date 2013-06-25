/*global describe, it, expect, beforeEach, loadFixtures, sinon, $, Event, Mopo */
describe("Mopo.Views.LinkForm", function () {
  describe('createLink', function () {
    var scrap, collection, view, e;

    beforeEach(function () {
      loadFixtures('link_form.html');
      //rerender jquery mobile
      $("#new_link").trigger('create');

      scrap = new Mopo.Models.Scrap({
        id: 123
      });

      collection = new Mopo.Collections.Links();
      collection.create = sinon.spy();

      view = new Mopo.Views.LinkForm({
        el: $("#new_link"),
        scrap: scrap,
        collection: collection
      });
      view.render();

      e = new Event(undefined);
    });

    it('does nothing when blank url', function () {
      expect(view.createLink(e)).toBeFalsy();
      expect(view.collection.create).not.toHaveBeenCalled();
    });
    it('adds new link', function () {
      view.$('#link_url').val('mopo.livingjunction.com');
      view.createLink(e);

      expect(view.collection.create).toHaveBeenCalled();
    });
  });
});