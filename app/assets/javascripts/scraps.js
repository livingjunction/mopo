/*global jQuery, document, Mopo, window, FB, twttr */
(function ($) {
  $(document).on('pageinit', '.page', function (e) {

    var $page = $(e.currentTarget),
      $scrapView = $('.scrap-view', $page),
      $scrapLikes = $('.scrap-likes', $scrapView),
      $scrapComments = $('.scrap-comments', $scrapView),
      $scrapFlag = $('.scrap-flags', $scrapView),
      $pagination = $('.pagination', $page),
      $newEditScrapView = $('#new-edit-scrap-view', $page),
      viewLikes,
      viewFlagButton,
      viewCommentsList,
      scrapViewData,
      scrap,
      currentUserId,
      likes,
      comments,
      flagData,
      flag;

    //new, edit
    if ($newEditScrapView.length) {
      new Mopo.Views.ScrapForm({
        el: $newEditScrapView,
        model: new Mopo.Models.Scrap($newEditScrapView.data().scrap),
        assets: new Mopo.Collections.Assets($newEditScrapView.data().assets),
        links: new Mopo.Collections.Links($newEditScrapView.data().links)
      }).render();
    }

    //show
    if ($scrapView.length) {
      scrapViewData = $scrapView.data();
      scrap = new Mopo.Models.Scrap(scrapViewData.scrap);
      currentUserId = scrapViewData.currentUserId;
      likes = new Mopo.Collections.Likes($scrapLikes.data().likes);
      comments = new Mopo.Collections.Comments($scrapComments.data().comments);

      flagData = $scrapFlag.data().flag || {
        user_id: currentUserId,
        scrap_id: scrap.get('id')
      };
      flag = new Mopo.Models.Flag(flagData);

      viewLikes = new Mopo.Views.Likes({
        el: $scrapLikes,
        collection: likes,
        scrap: scrap,
        user_id: currentUserId
      }).render();

      viewFlagButton = new Mopo.Views.FlagButton({
        el: $scrapFlag,
        model: flag
      }).render();

      viewCommentsList = new Mopo.Views.CommentsList({
        el: $scrapComments,
        collection: comments,
        scrap: scrap
      }).render();
    }
  });

  $(document).on('pageshow', '.page', function (e) {
    var $page = $(e.currentTarget),
      $fbLike = $('.scrap-fb-like', $page),
      $tweet = $('.scrap-tweet', $page);

    //fb like button
    if ($fbLike.length) {
      try {
        FB.XFBML.parse();
      } catch (err) {}
    }

     //reload tweet button
    if ($tweet.length && typeof twttr !== "undefined" && twttr.widgets) {
      twttr.widgets.load();
    }
  });
}(jQuery));