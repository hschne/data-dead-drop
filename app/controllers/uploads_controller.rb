# frozen_string_literal: true

class UploadsController < ApplicationController
  before_action :set_upload, only: %i[show preview]

  def show; end

  def preview; end

  def new
    @upload = Upload.new
  end

  def create
    @upload = Upload.new(upload_params)

    respond_to do |format|
      if @upload.save
        format.html { redirect_to upload_url(@upload), notice: 'Upload was successfully created.' }
        format.json { render :show, status: :created, location: @upload }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_upload
    @upload = Upload.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def upload_params
    params.require(:upload).permit(:path, :data, :expiry, :remaining_uses, :previewed)
  end
end
