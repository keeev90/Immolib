class AddPropertyToAppointments < ActiveRecord::Migration[5.2]
  def change
    add_reference :appointments, :property, foreign_key: true
  end
end
