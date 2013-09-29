# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.panel-body').hide().css('padding', '7px').find('.list-group').css('margin', 0)
  
  $(".list-expander").click ->
    $(@).siblings('.panel-body').slideToggle('fast')
  
  $('.select2').each ->
    this_input = $(@)
    url = $(@).data('url')
    $(@).val('') if $(@).val() == '[]'
    $(@).select2(
      initSelection: (elm, callback)->
        data = $.parseJSON($(elm).val())
        data = if data.length then data else ''
        input_val = []
        input_val.push(item.id) for item in data
        this_input.attr 'value', input_val
        callback data
      multiple: true
      ajax:
        url: url,
        dataType: 'json',
        results: (data) ->
          console.log data
          results: data
        data: (term) ->
          query: term
      formatResult: (item) ->
        item.name
      formatSelection: (item) ->
        item.name
    )
