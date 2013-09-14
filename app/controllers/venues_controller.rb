class VenuesController < ApplicationController

  load_and_authorize_resource edit: [:edit_media, :add_show]

  def show
    continue_registration_or_show_user @venue
  end

  def edit
  end

  def edit_media
  end

  def add_show
  end

  def update
    if @venue.update_attributes(venue_params)
      advance_registration_or_redirect_to @venue
    else
      redirect_to current_sign_up_step
    end
  end

  def index
  end

  def find
    render json: Venue.to_autocomplete(params[:query])
  end


  private

  def venue_params
    @params ||= params.permit(:venue).permit(:name, :address, :links, :description, :menu,
                                  { videos_attributes: [:upload], images_attributes: [:upload] })
  end

end
