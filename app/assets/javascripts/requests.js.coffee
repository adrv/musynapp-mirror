# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  toggleControlsVisibility = (cond) ->
    $selection = $('#selection_actions')
    if cond
      $selection.css('visibility', 'visible')
    else
      $selection.css('visibility', 'hidden')

  $('.requests_selection').click (e) =>
    toggleControlsVisibility $('input:checked').length

  $('#select_all').click ->
    is_checked = $(@).data('checked')
    $(@).data 'checked', !is_checked
    changed = $(@).data 'checked'
    $(':checkbox').prop('checked', changed)
    toggleControlsVisibility changed
