# frozen_string_literal: true

class DropsController < ApplicationController
  before_action :set_drop, only: %i[show edit update destroy]

  def show; end

  def preview; end

  def new
    @drop = Drop.new
  end

  def create
    @drop = Drop.new(drop_params)

    respond_to do |format|
      if @drop.save
        format.html { redirect_to drop_url(@drop), notice: 'Drop was successfully created.' }
        format.json { render :show, status: :created, location: @drop }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @drop.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_drop
    @drop = Drop.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def drop_params
    params.require(:drop).permit(:path, :data, :expiry, :remaining_uses)
  end
end
