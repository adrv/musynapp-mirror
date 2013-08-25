class Song < ActiveRecord::Base
  has_attached_file :upload
  belongs_to :band

  validates_attachment_content_type :upload, content_type: %w(audio/mpeg audio/ogg audio/mp3 audio/mp4 audio/vnd.wave audio/x-ms-wma)
end
