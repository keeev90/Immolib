class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.belongs_to :property
      t.string :url
      t.string :slug
      t.integer :clicked, default: 0
      t.timestamps
    end
  end
end
