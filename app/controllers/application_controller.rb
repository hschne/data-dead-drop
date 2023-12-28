# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def home; end
  def legal; end

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end
end
