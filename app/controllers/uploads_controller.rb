class UploadsController < ApplicationController

  def create
    upload = build_upload(find_user)
    if upload.save
      render json: upload.to_jq_upload
    else
      render json: { errors: upload.errors.full_messages, status: 422 }
    end
  end

  def destroy
    find_uploadable.destroy
    render json: { status: 200 }
  end

  def download
    file = find_uploadable.upload
    method = file.content_type['pdf'] ? 'inline' : 'attachment'
    send_file file.path, disposition: method
  end

  def make_primary
    find_uploadable.make_primary_for find_user
    render json: {}
  end


  private

  def find_user
    @parent = uploader_params[:user_type].camelize.constantize.find(uploader_params[:user_id])
  end

  def find_uploadable
    @uploadable ||= uploader_params[:type].camelize.constantize.find(uploader_params[:id])
  end

  def build_upload parent
    [:images, :songs, :videos].each do |media_type|
      if uploader_params[media_type].present?
        return parent.send(media_type.to_s).build uploader_params[media_type]
      end
    end
    if (menu_params = uploader_params[:menu]).present?
      return parent.build_menu menu_params
    end
  end

  def uploader_params
    params.permit(:id, :type, :user_id, :user_type, images: [:upload], videos: [:upload], songs: [:upload], menu: [:upload] )
  end
end
