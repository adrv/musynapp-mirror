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
  end

  def update
    respond_to do |format|
      if @band.update_attributes(band_params)
        format.html { proceed_registration || redirect_to(@band) }
        format.json { render json: @band.send(updated_media_type).last.to_jq_upload }
      else
        format.html { redirect_to current_user.current_step }
        format.json { render json: { errors: @band.errors.full_messages, status: 422 } }
      end
    end
  rescue => e
    logger.debug e
    render json: { errors: @band.errors.full_messages, status: 422 }
  end

  
  private

  def band_params
    params.require(:band).permit(:name, :genre_id, :description, :links,
                                 { songs_attributes: [:upload], images_attributes: [:upload] } )
  end

  def updated_media_type
    band_params[:songs_attributes].present? ? :songs : :images
  end

end
