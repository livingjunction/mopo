$ = jQuery
$(document).on 'pageinit', '.page', (e) ->
  form = $(e.currentTarget).find('form#user-scraps-category-filter')
  form.find('select').change ->
    form.submit()