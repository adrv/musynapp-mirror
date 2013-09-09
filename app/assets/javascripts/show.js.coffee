$ ->
  for class_name in ['find_band', 'find_venue']
    $(".#{class_name}").typeahead 
      name: Math.random(),
      remote: "/#{class_name}/?query=%QUERY"
