class AssetsController < ApplicationController
  load_and_authorize_resource :asset, :except => [:create]

  respond_to :json, :only => [:destroy]

  def create
    authorize! :create, Asset
    @asset = params[:type].constantize.new(params[:asset])
    @asset.user = current_user

    # hack for ie9
    # http://whywontitjustwork.blogspot.fi/2013/02/getting-jquery-file-upload-to-play.html
    # https://github.com/blueimp/jQuery-File-Upload/issues/123
    respond_to do |format|
      if @asset.save
        format.json {
          render content_type: 'text/plain', json: @asset, status: :created
        }
      else
        format.json {
          #replace Paperclip processor error msg
          if @asset.errors[:asset].present?
            @asset.errors.clear
            @asset.errors.add(:asset, I18n.t("errors.models.asset.processing"))
          end
          render content_type: 'text/plain', json: @asset.errors, status: :unprocessable_entity
        }
      end
    end
  end

  def destroy
    @asset.destroy
    respond_with(@asset)
  end

end
