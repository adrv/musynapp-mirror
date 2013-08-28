class Image < ActiveRecord::Base
  has_attached_file :upload, styles: { thumb: '300x300' }
  belongs_to :imageable, polymorphic: true

  validates_attachment_content_type :upload, content_type: %w(image/gif image/jpeg image/png)

  include Rails.application.routes.url_helpers

  def to_jq_upload
    {
      "name" => read_attribute(:upload_file_name),
      "size" => read_attribute(:upload_file_size),
      "url" => upload.url(:thumb)
    }
  end
end
