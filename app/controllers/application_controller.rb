class ApplicationController < ActionController::Base
  include UsersHelper

  # rescue_from ActiveRecord::RecordNotFound, with: record_not_found
  
  private

  # def record_not_found
  #   render file: 'public/404.html', status: 404
  # end
end
