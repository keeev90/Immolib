class AddPaidStatusToProperties < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :is_paid, :boolean, default: :false
  end
end
