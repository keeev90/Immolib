class CreateSlots < ActiveRecord::Migration[5.2]
  def change
    create_table :slots do |t|
      t.belongs_to :property
      t.datetime :start_date
      t.integer :duration
      t.integer :max_appointments
      t.timestamps
    end
  end
end
