/*global describe, it, expect, Mopo */
describe("Mopo.Views.LinkItem", function () {
  describe('render', function () {
    it("truncates long url", function () {
      var link = new Mopo.Models.Link({
          url: "123456789b123456789c123456789d123456789.com"
        }),
        view = new Mopo.Views.LinkItem({
          model: link
        });

      view.render();

      expect(view.$el).toHaveText("123456789b123456789c12345...");
    });
  });

});