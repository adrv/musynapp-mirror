class BandsController < ApplicationController
  
  load_resource edit: [:edit_media, :request_address]
  authorize_resource except: :show

  def show
    continue_registration_or_redirect_to @band
  end

  def edit
  end

  def edit_media
  end

  def update
    update_registrateable_process @band, band_params
  end

  def destroy
    @band.destroy
    flash[:info] = "This account has been canceled"
    redirect_to root_path
  end

  def find
    render json: Band.to_autocomplete(params[:query])
  end

  def request_address
    @band.send_address_request_for current_user.registrateable
    flash[:info] = 'Your request is sent'
    redirect_to :back
  end

  
  private

  def band_params
    params.require(:band).permit(:name, :genre_id, :description, :links, :id,
                                 { songs_attributes: [:upload], images_attributes: [:upload] } )
  end

end
