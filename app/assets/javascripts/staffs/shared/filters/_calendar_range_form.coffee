$(document).on 'turbolinks:load', (event) ->
  $('#filter-begin-date').on 'change', (event) ->
    $('#filter-end-date').attr('min', $(this).val())
  $('#filter-end-date').on 'change', (event) ->
    $('#filter-begin-date').attr('max', $(this).val())
