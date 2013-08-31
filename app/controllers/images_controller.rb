class ImagesController < ApplicationController
  load_resource

  def destroy
    if img = @image.destroy
      render json: { deleted_img: img.id }
    end
  end

end