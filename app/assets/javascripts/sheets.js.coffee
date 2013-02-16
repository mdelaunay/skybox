jQuery ->
  $('#new_sheet').fileupload
    dataType: "script"
    add: (e, data) ->
      # types = /(\.|\/)(gif|jpe?g|png)$/i
      file = data.files[0]
      data.context = jQuery.parseHTML '<div class="upload" id="progress-' + file.name.hashCode() + '" >' + file.name + '<div class="progress"><div class="bar" style="width: 0%"></div></div></div>'
      $('#new_sheet').append(data.context)
      data.submit()
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        $(data.context).find('.bar').css('width', progress + '%')
    done: (e, data) ->
      $(data.context).empty()