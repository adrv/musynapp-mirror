module ApplicationHelper
  require 'uri' 

  def valid?(uri)
    uri = URI.parse(uri)
    uri.kind_of?(URI::HTTP) || uri.kind_of?(URI::HTTPS)
  rescue URI::InvalidURIError
    false
  end
end
