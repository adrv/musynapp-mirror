class ImagesController < ApplicationController

  load_resource edit: :make_primary

  def make_primary
    @image.make_primary_for_band
    render json: {}
  end


  private

  def songs_params
    params.permit!
  end

end
