class VenuesController < ApplicationController

  load_resource edit: [:edit_media, :add_show]
  authorize_resource except: :show

  before_filter :prepare_media_params, only: :update

  def show
  end

  def edit
  end

  def edit_media
    (3 - @venue.videos.count).times do
      @venue.videos.build
    end
    (3 - @venue.images.count).times do
      @venue.images.build
    end
  end

  def add_show
  end

  def update
    prepare_media_params

    respond_to do |format|
      if @venue.update_attributes(venue_params)
        format.html { proceed_registration || redirect_to(@band) }
        format.json { render json: [@media_response.to_jq_upload] }
      else
        format.html { redirect_to current_sign_up_step }
        format.json { render status: 'fail' }
      end
    end
  end


  private

  def venue_params
    @params ||= params.require(:venue).permit(:name, :address, :links, :description, :menu,
                                  { images: [], videos: [], videos_attributes: [:upload], images_attributes: [:upload] })
  end

  def prepare_media_params
    [:images, :videos].each do |media_type|
      if venue_params[media_type] and venue_params[media_type].first.is_a?(ActionDispatch::Http::UploadedFile)
        venue_params[media_type].each do |media|
          @media_response = @venue.send(media_type).create(upload: media)
        end
        @params.delete media_type
      end
    end
  end

end
