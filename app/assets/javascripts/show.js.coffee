$ ->
  for id in ['bands', 'venues']
    $("##{id}").typeahead 
      name: Math.random(),
      remote: "/#{id}/find/?query=%QUERY"
