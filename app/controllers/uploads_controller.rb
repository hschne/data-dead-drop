# frozen_string_literal: true

class UploadsController < ApplicationController
  include ActiveStorage::SetCurrent
  include ActionController::Live

  def new
    @upload = Upload.new(expiry: 10.minutes.from_now, remaining_uses: 1)
  end

  def upload
    @upload = Upload.new(upload_params)
    @upload.key = Upload.generate_key

    respond_to do |format|
      if @upload.save
        format.html { redirect_to preview_url(@upload) }
        format.json { render :preview, status: :created, location: @upload }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  def preview
    @upload = upload_scope.where(previewed: false).find_by!(key: params[:id])
    @upload.update!(previewed: true)
    respond_to do |format|
      format.html { render :preview, status: :not_found }
    end
  end

  def download
    @upload = upload_scope.find_by!(key: params[:id])
    @upload.decrement!(:remaining_uses)

    redirect_to rails_blob_path(@upload.data, disposition: 'attachment')
    # send_data @upload.data.download, filename: @upload.data.filename.to_s, content_type: @upload.data.content_type
  end

  private

  def upload_scope
    Upload.where('expiry > ?', DateTime.now).where('remaining_uses > ?', 0)
  end

  # Only allow a list of trusted parameters through.
  def upload_params
    params
      .require(:upload).permit(:data, :expiry, :remaining_uses)
  end
end
