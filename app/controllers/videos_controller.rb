class VideosController < ApplicationController

  load_resource

  def destroy
    if video = @video.destroy
      render json: { deleted_img: video.id }
    end
  end

end
