class BandsController < ApplicationController

  load_resource edit: :edit_media
  authorize_resource except: :show

  def show
    if @band.registration.pending? and (@band.registration.id == current_user.id)
      redirect_to action: current_user.current_step
    else
      render 'show'
    end
  end

  def edit
  end

  def edit_media
  end

  def update
    if @band.update_attributes(band_params)
      proceed_registration_or_redirect_to @band
    else
      redirect_to current_user.current_step
    end
  end

  def find
    render json: Band.to_autocomplete(params[:query])
  end

  
  private

  def band_params
    params.permit(:band).permit(:name, :genre_id, :description, :links,
                                 { songs_attributes: [:upload], images_attributes: [:upload] } )
  end

end
