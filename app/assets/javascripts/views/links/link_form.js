/*jslint nomen: true */
/*global Mopo, Support, JST, _ */
Mopo.Views.LinkForm = Support.CompositeView.extend({

  events: {
    "click button#add_link": "createLink"
  },

  initialize: function () {
    this.scrap = this.options.scrap;
  },

  createLink: function (e) {
    e.preventDefault();
    var self = this,
      $submitButton = this.$('#add_link'),
      $linkUrl = this.$('#link_url'),
      linkUrl = $linkUrl.val(),
      link;

    self.$("table tr.error").remove();

    if (_.str.isBlank(linkUrl)) {
      return false;
    }
    $submitButton.button('disable');

    link = new Mopo.Models.Link({
      url: linkUrl,
      scrap_id: this.scrap.get('id')
    });
    this.collection.create(link, {
      wait: true,
      success: function () {
        $linkUrl.val('');
        $submitButton.button('enable');
      },
      error: function (model, response, options) {
        var attributesWithErrors = JSON.parse(response.responseText),
          urlError = attributesWithErrors.errors.url || "invalid",
          urlErrorTmpl = JST['links/item_error']({
            error: urlError
          });

        self.$('table').append(urlErrorTmpl);
        $submitButton.button('enable');
      }
    });
  }
});