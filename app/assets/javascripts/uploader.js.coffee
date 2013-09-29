$ ->
  $('body').on 'click', '.delete-uploaded-item', ->
    $.ajax
      url: $(@).attr('delete_href')
      type: 'DELETE'
      success: (rsp) =>
        console.log rsp
        $(@).closest('tr').fadeOut()

  $('.primary_media').change ->
    console.log @checked
    $.ajax
      type: 'POST'
      url: "/uploads/#{$(@).attr('value')}/make_primary"
      data:   { type: "#{$(@).data('type')}",  user_type: "#{$(@).data('user_type')}", user_id: "#{$(@).data('user_id')}" }

  $("#fileupload-images, #fileupload-videos, #fileupload-songs, #fileupload-menu").fileupload
    dataType: 'json'
    type: 'POST'
    done: (_, data) ->
      $form = $(@)
      form_id = $form.attr('id')
      $form.find('.progress').fadeOut()
      console.log data
      if errors = data.result.errors
        $form.prepend $("<div class='alert alert-error'>#{errors[0]}</div>")
      else
        $("##{form_id}-tmpl").append JST['shared/uploader_item'](item: data.result)
    add: (_, data)->
      console.log 'here'
      data.submit()
    progress: (_, data)->
      completeness = (data.loaded / data.total) * 100
      console.log data
      $(@).find('.progress').show().find('.bar').css('width', "#{completeness}%")
