class VenuesController < ApplicationController

  load_resource edit: [:edit_media, :add_show]
  authorize_resource except: :show

  def show
    if @venue.registration.pending? and (@venue.registration.id == current_user.id)
      redirect_to action: current_user.current_step
    else
      render 'show'
    end
  end

  def edit
  end

  def edit_media
  end

  def add_show
  end

  def update
    if @venue.update_attributes(venue_params)
      proceed_registration_or_redirect_to @venue
    else
      redirect_to current_sign_up_step
    end
  end


  private

  def venue_params
    @params ||= params.permit(:venue).permit(:name, :address, :links, :description, :menu,
                                  { videos_attributes: [:upload], images_attributes: [:upload] })
  end

end
