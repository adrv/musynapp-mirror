class Menu < ActiveRecord::Base
  belongs_to :venue
  has_attached_file :upload

  validates_attachment_content_type :upload, content_type: 'application/pdf'
  
  after_save :generate_thumb
  # Fix unknown path
  # before_destroy :remove_thumb

  include Rails.application.routes.url_helpers

  def to_jq_upload
    {
      'name' => read_attribute(:upload_file_name),
      'size' => read_attribute(:upload_file_size),
      'url' => thumb,
      'download_url' => download_upload_path(:id => id, type: 'menu'),
      'content_type' => upload_content_type, 
      'delete_url' => upload_path(:id => id, type: 'menu')
    }
  end

  def thumb
    "#{upload.url.gsub(/\?.*/, '')}.png"
  end

  private

  def generate_thumb
    pdf = Magick::ImageList.new(upload.path)
    pdf.scale(150, 150).write "#{upload.path}.png"
  end

  def remove_thumb
    system "rm #{upload.path}.png"
  end


end
