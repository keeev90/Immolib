class SlotsController < ApplicationController
  def index
    @slots = Property.find(params[:property_id]).slots
  end

  def show
  end

  def new
    @slot = Slot.new
    @property = Property.find(params[:property_id])
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
