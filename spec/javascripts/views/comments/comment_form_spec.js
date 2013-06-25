/*global describe, it, expect, Mopo, beforeEach, sinon, Event */
describe("Mopo.Views.CommentForm", function () {
  describe('render', function () {
    it("form with proper fields", function () {
      var view = new Mopo.Views.CommentForm();
      view.render();
      expect(view.$el).toBe("form");
      expect(view.$el).toContain("textarea#comment_body");
      expect(view.$el).toContain("button");
    });
  });

  describe('createComment', function () {
    var scrap, collection, view, e;

    beforeEach(function () {
      scrap = new Mopo.Models.Scrap({
        id: 123
      });

      collection = new Mopo.Collections.Comments();
      collection.create = sinon.spy();

      view = new Mopo.Views.CommentForm({
        scrap: scrap,
        collection: collection
      });
      view.render();

      e = new Event(undefined);
    });

    it('does nothing when blank body', function () {
      expect(view.createComment(e)).toBeFalsy();
      expect(view.collection.create).not.toHaveBeenCalled();
    });
    it('adds new comment', function () {
      view.$('#comment_body').val('Lorem ipsum');
      view.createComment(e);

      expect(view.collection.create).toHaveBeenCalled();
    });
  });
});