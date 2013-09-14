class ShowsController < ApplicationController
  load_and_authorize_resource except: :create
  authorize_resource only: :create

  def new
    @show = Show.new
  end

  def create
    @show = current_user.registrateable.shows.build(show_params)
    build_opposite_association
    if @show.save
      flash[:notice] = 'Successfully created'
      redirect_to @show
    else
      flash.now[:error] = @show.errors.messages.map{ |key,val| "#{key} #{val}\n" }
      render :new 
    end
  end

  def edit
  end

  def update
    build_opposite_association
    if @show.update_attributes(show_params)
      flash[:notice] = 'Successfully updated'
      redirect_to @show
    else
      flash.now[:error] = @show.errors.messages.map{ |key,val| "#{key} #{val}\n" }
      render :new
    end
  end

  def show
  end

  private

  def show_params
    params.require(:show).permit(:id, :dt, :crowd_size, :cost, :description, :address, :private)
  end

  def opposite_params
    params.require(:opposite).permit(:type, :name)
  end

  def build_opposite_association
    association = opposite_params[:type]
    name = opposite_params[:name]
    @show.send("#{association}=", association.camelize.constantize.find_or_create_by_name(name: name, virtual: true))
  end

end
