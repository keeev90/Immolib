class Admin::WelcomeController < ApplicationController
  #Callbacks
  before_action :authenticate_user!
  before_action :is_admin?

  def index
    @users = User.all
  end

end
