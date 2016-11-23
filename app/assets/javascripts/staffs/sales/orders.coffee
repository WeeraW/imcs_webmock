# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', (event) ->
  $('#order_details').on 'cocoon:before-insert', (event, inserted_field) ->
    order_detail_selecteds = $(@).children()
    selected_values = ($(selected_order).find('.product_detail_selected').val() for selected_order in order_detail_selecteds)
    console.log selected_values
    for value in selected_values
      $(inserted_field).find(".product_detail_selected option[value='#{value}']").remove()
