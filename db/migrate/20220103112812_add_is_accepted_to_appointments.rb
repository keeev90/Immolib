class AddIsAcceptedToAppointments < ActiveRecord::Migration[5.2]
  def change
    add_column :appointments, :is_accepted, :boolean
  end
end
