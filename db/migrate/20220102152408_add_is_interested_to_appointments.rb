class AddIsInterestedToAppointments < ActiveRecord::Migration[5.2]
  def change
    add_column :appointments, :is_interested, :boolean
  end
end
