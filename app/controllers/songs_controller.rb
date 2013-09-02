class SongsController < ApplicationController

  load_resource

  def destroy
    if song = @song.destroy
      render json: { deleted_song: video.id }
    end
  end

end
