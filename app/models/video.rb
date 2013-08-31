class Video < ActiveRecord::Base
  has_attached_file :upload

  validates_attachment_content_type :upload, content_type: %w(video/mpeg video/mp4 video/ogg)

  include Rails.application.routes.url_helpers

  def to_jq_upload
    {
      "name" => read_attribute(:upload_file_name),
      "size" => read_attribute(:upload_file_size),
      "url" => upload.url,
      "content_type" => upload_content_type,
      "delete_url" => video_path(:id => id)
    }
  end
end
