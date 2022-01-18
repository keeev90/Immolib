class ChangeIsPaidDefaultValueToProperties < ActiveRecord::Migration[5.2]
  def change
    change_column_default :properties, :is_paid, true
  end
end
