class ShowsController < ApplicationController
  load_and_authorize_resource

  def new
  end

  def create
    if @show = Show.create(show_params)
      flash[:notice] = 'Successfully created'
      redirect_to :root
    else
      flash.now[:error] = @show.errors.messages.map{ |key,val| "#{key} #{val}\n" }
      render :new 
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  private

  def show_params
    params.require(:show).permit(:id, :datetime, :venue, :band, :venue_id, :band_id, :crowd_size, :cost, :description, :address, :private)
  end

end
