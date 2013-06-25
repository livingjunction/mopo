/*global describe, it, expect, Mopo, I18n */
describe("Mopo.Views.NotificationItem", function () {
  describe('render', function () {
    it("has proper content when flag is deleted", function () {
      // real data from alpha
      var notification = new Mopo.Models.Notification({
          activity: {
            action: "create",
            created_at: "2013-05-20T08:20:59Z",
            trackable: null,
            trackable_type: "flag",
            user_full_name: "Severus Snape"
          }
        }),
        view = new Mopo.Views.NotificationItem({
          model: notification
        });

      view.render();

      expect(view.$el).toContain("p.activity-deleted");
    });

    it("has proper content when comment is deleted", function () {
      var notification = new Mopo.Models.Notification({
          activity: {
            action: "create",
            created_at: "2013-05-20T08:20:59Z",
            trackable: null,
            trackable_type: "comment",
            user_full_name: "Severus Snape"
          }
        }),
        view = new Mopo.Views.NotificationItem({
          model: notification
        });

      view.render();

      expect(view.$el).toContain("p.activity-deleted");
    });
  });

});