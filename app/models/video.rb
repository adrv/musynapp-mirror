class Video < ActiveRecord::Base
  belongs_to :venue
  has_attached_file :upload

  validates_attachment_content_type :upload, content_type: %w(video/mpeg video/mp4 video/ogg video/quicktime video/x-ms-wmv video/x-flv video/webm)
  validate :dont_exceed_limit

  include Rails.application.routes.url_helpers

  def to_jq_upload
    {
      "name" => read_attribute(:upload_file_name),
      "size" => read_attribute(:upload_file_size),
      "url" => upload.url,
      "content_type" => upload_content_type,
      "delete_url" => upload_path(:id => id, type: 'video'),
      "download_url" => download_upload_path(:id => id, type: 'video')
    }
  end

  private

  def dont_exceed_limit
    errors.add(:upload, 'Only 3 videos allowed') if self.venue.videos.count >= 3 
  end
end
