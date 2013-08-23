class FansController < ApplicationController

  load_resource

  def edit
  end

  def update
    @fan = Fan.find(params[:id])
    if @fan.update_attributes(fan_params)
      render text: 'success'
    else
      render text: @fan.errors.full_messages
    end
  end


  private


  def fan_params
     params.require(:fan).permit(favorite_band_ids: [],
                                  favorite_venue_ids: [],
                                  friend_ids: [])
  end

end
