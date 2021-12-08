class AppointmentsController < ApplicationController
  def index
  end

  def new
  end

  def create
    puts params
    puts "la titi"
    puts "#" * 50
    redirect_to root_path
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
