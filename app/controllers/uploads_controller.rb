# frozen_string_literal: true

class UploadsController < ApplicationController
  include ActiveStorage::SetCurrent

  skip_before_action :verify_authenticity_token, only: %i[upload preview]

  def new
    @upload = Upload.new(expiry: 10, uses: 1)
  end

  def upload
    @upload = Upload.new(upload_params)
    @upload.expiry = upload_params[:expiry].to_i.minutes.from_now
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
    render :preview
  end

  def download
    @upload = upload_scope.find_by!(key: params[:id])
    @upload.decrement!(:uses) # rubocop:disable Rails/SkipsModelValidations

    file = @upload.file
    redirect_to(file.url(disposition: 'attachment', filename: file.filename.to_s),
                allow_other_host: true)
  end

  private

  def upload_scope
    Upload.where('expiry > ?', DateTime.now).where(uses: (1..))
  end

  # Only allow a list of trusted parameters through.
  def upload_params
    params
      .require(:upload).permit(:file, :expiry, :uses)
      .with_defaults(expiry: 10, uses: 1)
  end
end
