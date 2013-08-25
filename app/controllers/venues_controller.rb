class VenuesController < ApplicationController

  load_resource edit: [:edit_media, :edit_schedule]
  authorize_resource except: :show

  def show
  end

  def edit
  end

  def edit_media
  end

  def edit_schedule
  end

  def update
    if @venue.update_attributes(venue_params)
      redirect_to( next_sign_up_step || @venue )
    else
      redirect_to current_sign_up_step 
  end
end
