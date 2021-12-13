class AddIsRentalToProperties < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :owner_project, :string
  end
end
