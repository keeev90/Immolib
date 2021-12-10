class CreateProperties < ActiveRecord::Migration[5.2]
  def change
    create_table :properties do |t|
      t.string :title 
      t.string :city 
      t.string :other_link
      t.text :instructions
      t.references :owner, index: true
      t.timestamps
    end
  end
end
