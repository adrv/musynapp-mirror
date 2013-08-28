$ ->
  $("#fileupload").fileupload
    dataType: 'json'
    type: 'PUT'
    done: (e, data) ->
      for file in data.result
        $('body').append("<br><img src=#{file.url}</img>")
      # $.each data.result.files, (index, file) ->
      #   $("<p/>").text(file.name).appendTo document.body
    add: (_, data)->
      # console.log data
      data.submit()
      for file in data['files']
        $('body').append("<br><audio controls><source src='#{file.name}' type='audio/mpeg'></audio>")
