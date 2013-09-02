class VenuesController < ApplicationController

  load_resource edit: [:edit_media, :add_show]
  authorize_resource except: :show

  def show
  end

  def edit
  end

  def edit_media
  end

  def add_show
  end

  def update
    respond_to do |format|
      if @venue.update_attributes(venue_params)
        format.html { proceed_registration || redirect_to(@band) }
        format.json { render json: @venue.send(updated_media_type).last.to_jq_upload }
      else
        format.html { redirect_to current_sign_up_step }
        format.json { render json: { errors: @venue.errors.full_messages, status: 422 } }
      end
    end
  rescue => e
    logger.debug e
    render json: { errors: @venue.errors.full_messages, status: 422 }
  end


  private

  def venue_params
    @params ||= params.require(:venue).permit(:name, :address, :links, :description, :menu,
                                  { videos_attributes: [:upload], images_attributes: [:upload] })
  end

  def updated_media_type
    venue_params[:videos_attributes].present? ? :videos : :images
  end

end
