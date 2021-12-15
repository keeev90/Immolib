class AddStripeProductIdoProperties < ActiveRecord::Migration[5.2]
  def change
    change_table :properties do |t|
      t.string :stripe_price_id
    end
  end
end
