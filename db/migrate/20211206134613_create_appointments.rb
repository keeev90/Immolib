class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.references :candidate, index: true
      t.belongs_to :slots
      t.timestamps
    end
  end
end
