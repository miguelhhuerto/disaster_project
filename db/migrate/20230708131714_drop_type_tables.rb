class DropTypeTables < ActiveRecord::Migration[7.0]
  def change
    drop_table :post_type_ships
    drop_table :types
  end
end
