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
    (3 - @band.songs.count).times do
      @band.songs.build
    end
    (3 - @band.images.count).times do
      @band.images.build
    end
  end

  def update
    if @band.update_attributes(band_params)
      proceed_registration || redirect_to(@band)
    else
      flash.now[:error] = @band.errors.messages.map{ |key,val| "#{key} #{val}\n" } 
      render( current_user.current_step || params[:form_id] )
    end
  end

  
  private

  def band_params
    params.require(:band).permit(:name, :genre_id, :description, :links,
                                 { songs_attributes: [:upload], images_attributes: [:upload] } )
  end

end
