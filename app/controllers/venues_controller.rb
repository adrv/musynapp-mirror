class VenuesController < ApplicationController

  load_and_authorize_resource edit: [:edit_media, :add_show]

  def show
    continue_registration_or_redirect_to @venue
  end

  def edit
  end

  def edit_media
  end

  def add_show
  end

  def update
    update_registrateable_process @venue, venue_params
  end

  def index
  end

  def destroy
    @venue.destroy
    flash[:info] = "This account has been canceled"
    redirect_to root_path
  end

  def find
    render json: Venue.to_autocomplete(params[:query])
  end


  private

  def venue_params
    @params ||= params.require(:venue).permit(:name, :address, :links, :description, :menu,
                                  { videos_attributes: [:upload], images_attributes: [:upload] })
  end

end
