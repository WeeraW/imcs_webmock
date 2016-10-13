# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', (event) ->
  $('#warehouse_print_address_labels_btn').attr('disabled', true)
  $('#warehouse_print_stock_cutter_recipe_btn').attr('disabled', true)
  $('#warehouse_print_billing_receipt_btn').attr('disabled', true)
  $('.selected_order').on 'change', (event) ->
    # clear DOM
    $('#selected_order_for_print_address_ids').html('')
    $('#selected_order_for_print_stock_cutter_recipe_ids').html('')
    # Set addresses for render pdf
    for checked_id in $('.selected_order:checked')
      selected_id = document.createElement('input')
      selected_id.setAttribute('type', 'hidden')
      selected_id.setAttribute('name', 'order_ids[]')
      selected_id.value = checked_id.value
      $('#selected_order_for_print_address_ids').append $(selected_id).clone()

      $('#selected_order_for_print_stock_cutter_recipe_ids').append $(selected_id).clone()

      $('#selected_order_for_print_billing_receipt_recipe_ids').append $(selected_id).clone()

    if $('.selected_order:checked').length == 0
      $('#warehouse_print_address_labels_btn').attr('disabled', true)
      $('#warehouse_print_stock_cutter_recipe_btn').attr('disabled', true)
      $('#warehouse_print_billing_receipt_btn').attr('disabled', true)
    else
      $('#warehouse_print_address_labels_btn').attr('disabled', false)
      $('#warehouse_print_stock_cutter_recipe_btn').attr('disabled', false)
      $('#warehouse_print_billing_receipt_btn').attr('disabled', false)
  $('#select_all_row').on 'change', (event) ->
    if this.checked
      for dom in $('.selected_order')
        $(dom).prop('checked', true).change()
        console.log $(dom).prop('checked')
    else
      for dom in $('.selected_order')
        $(dom).prop('checked', false).change()
