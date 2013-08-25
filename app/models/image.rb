class Image < ActiveRecord::Base
  has_attached_file :upload
  belongs_to :imageable, polymorphic: true

  validates_attachment_content_type :upload, content_type: %w(image/gif image/jpeg image/png)
end
