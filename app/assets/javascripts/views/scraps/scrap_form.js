/*jslint nomen: true */
/*global Mopo, Support, JST, _, jQuery */
Mopo.Views.ScrapForm = Support.CompositeView.extend({
  assetIds: [],
  events: {
    "click #submit_scrap": "submitScrap",
    "click #media_link": "toggleAddLink"
  },

  initialize: function () {
    this.assets = this.options.assets;
    this.links = this.options.links;
    this.bindTo(this.assets, "add", this.renderAssets);
    this.bindTo(this.links, "add", this.renderLinks);
  },

  render: function () {
    this.renderScrap();
    this.renderAddLinks();
    this.renderLinks();
    this.renderAddAssets();
    this.renderAssets();
    return this;
  },

  renderScrap: function () {
    this.$("#new_scrap #scrap_name").val('');
    this.$("#new_scrap #scrap_description").val('');
  },

  renderAddLinks: function () {
    new Mopo.Views.LinkForm({
      el: this.$("#new_link"),
      scrap: this.model,
      collection: this.links
    }).render();
  },

  toggleAddLink: function () {
    this.$("#new_link").toggle();
  },

  renderAddAssets: function () {
    var self = this;

    this.$('#scrap-add-assets form').fileupload({
      dataType: "json",
      add: function (e, data) {
        data.context = jQuery(JST['assets/upload'](data.files[0]));
        self.$('#scrap-assets').prepend(data.context);
        data.submit();
      },
      progress: function (e, data) {
        //some browsers does not support progress upload
        //replace spinner with progress bar only when supported
        if (data.context) {
          var progress = parseInt(data.loaded / data.total * 100, 10),
            $progressBar = data.context.find('.progress');

          //show info about processing after asset was uploaded
          if (progress == 100) {
            data.context.find('.progress-bar').html(I18n.t('shared.assets.processing'));
          } else {
            if (!$progressBar.length) {
              $progressBar = jQuery(JST['shared/progress_bar']());
              data.context.find('.progress-bar').html($progressBar);
            }
            $progressBar.find('.bar').css('width', progress + '%');
          }
        }
      },
      done: function (e, data) {
        var new_asset = new Mopo.Models.Asset(data.result);
        data.context.remove();
        self.assets.add(new_asset);
      },
      fail: function (e, data) {
        var errors = new Mopo.Views.AssetErrors({
          attributesWithErrors: JSON.parse(data.jqXHR.responseText)
        });

        data.context.find('.progress-bar').html(errors.render().el);
      }
    });
  },

  renderAssets: function () {
    var container = this.$("#scrap-assets");

    container.empty();

    this.assets.each(function (asset) {
      var view = new Mopo.Views.AssetItem({
        model: asset
      });
      container.prepend(view.render().el);
    });
  },

  renderLinks: function () {
    var container = this.$("#scrap-links");

    container.empty();

    this.links.each(function (link) {
      var view = new Mopo.Views.LinkItem({
        model: link
      });
      container.prepend(view.render().el);
    });
  },

  submitScrap: function (e) {
    e.preventDefault();
    var self = this,
      $submitButton = this.$el.find('#submit_scrap'),
      $form = this.$('form#new_scrap, form[id*="edit_scrap"]'),
      name = this.$('#scrap_name').val(),
      description = this.$('#scrap_description').val(),
      privacy = this.$('input[name="scrap[privacy]"]:checked').val(),
      project_id = this.$('#scrap_project_id :selected').val();

    $submitButton.button('disable');

    this.model.save({
      project_id: project_id,
      name: name,
      description: description,
      privacy: privacy,
      assetIds: this.assets.pluck('id'),
      linkIds: this.links.pluck('id')
    }, {
      wait: true,
      success: function (model, response) {
        jQuery.mobile.changePage(self.model.url());
      },
      error: function (model, response, options) {
        var attributesWithErrors = JSON.parse(response.responseText);

        new Mopo.Views.FormErrors({
          el: $form,
          attributesWithErrors: attributesWithErrors.errors
        }).render();

        $submitButton.button('enable');
      }
    });
  }
});