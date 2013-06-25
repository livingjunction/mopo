$ = jQuery
$(document).on 'pageinit', '.page', (e) ->
  $(e.currentTarget).find('#category-assignments ul').sortable
    axis: 'y'
    containment: "parent"
    handle: ".handle"
    update: ->
      $(this).listview('refresh')
      $.post($(this).data('update-url'), $(this).sortable('serialize'))
