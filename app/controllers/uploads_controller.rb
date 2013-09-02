class UploadsController < ApplicationController

  def create
    upload = build_upload(find_parent)
    if upload.save
      render json: upload.to_jq_upload
    else
      render json: { errors: upload.errors.full_messages, status: 422 }
    end
  end

  def destroy
    find_upload.destroy
  end


  private

  def find_parent
    @parent = uploader_params[:parent_type].camelize.constantize.find(uploader_params[:parent_id])
  end

  def find_upload
    uploader_params[:type].camelize.constantize.find(uploader_params[:id])
  end

  def build_upload parent
    [:image, :song, :video].each do |media_type|
      if uploader_params[media_type].present?
        return parent.send(media_type.to_s.pluralize).build uploader_params[media_type]
      end
    end
  end

  def uploader_params
    params.permit(:id, :type, :parent_id, :parent_type, image: [:upload], video: [:upload], song: [:upload] )
  end
end
