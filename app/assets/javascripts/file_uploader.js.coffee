$ ->

  $(".delete-uploaded-item").click ->
    $.ajax
      url: $(@).attr('delete_href')
      type: 'DELETE'
      success: (rsp) =>
        console.log rsp
        $(@).closest('tr').fadeOut()

  $("#fileupload-images, #fileupload-videos").fileupload
    dataType: 'json'
    type: 'PUT'
    done: (e, data) ->
      $form = $(@)
      form_id = $form.attr('id')
      console.log data
      if errors = data.result.errors
        $form.prepend $("<div class='alert alert-error'>#{errors[0]}</div>")
      else
        $("##{form_id}-tmpl").append JST['shared/uploader_item'](item: data.result)
        
    add: (_, data)->
      # console.log data
      data.submit()
