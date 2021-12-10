class AppointmentsController < ApplicationController
  def index
  end

  def new
  end

  def create
    @appointment = Appointment.create(candidate: current_user, slot: Slot.find(params[:param1]))
    @property = Property.find(params[:property])
    redirect_to book_now_property_path(@property)
  end

  def show
    @appointment = Appointment.find(params[:id])
    @slots = @appointment.property.slots
    @date_arr = ["", "jan.", "fév.", "mar.", "avr.", "mai", "juin", "juil.", "août", "sept.", "oct.", "nov.", "déc."]
  end

  def edit
  end

  def update
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @property = Property.find(params[:property])
    @appointment.destroy
    redirect_to book_now_property_path(@property)
  end
end
