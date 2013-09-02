class Song < ActiveRecord::Base
  has_attached_file :upload
  belongs_to :band

  validates_attachment_content_type :upload, content_type: %w(audio/mpeg audio/ogg audio/mp3 audio/mp4 audio/vnd.wave audio/x-ms-wma)

  include Rails.application.routes.url_helpers

  def to_jq_upload
    {
      "name" => read_attribute(:upload_file_name),
      "size" => read_attribute(:upload_file_size),
      "url" => upload.url,
      "content_type" => upload_content_type, 
      "delete_url" => song_path(:id => id)
    }
  end
end
