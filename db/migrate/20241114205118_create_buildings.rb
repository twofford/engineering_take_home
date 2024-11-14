class CreateBuildings < ActiveRecord::Migration[7.2]
  def change
    create_table :buildings do |t|
      t.string :address_line_1, null: false
      t.string :address_line_2
      t.string :state, null: false
      t.string :zip, null: false
      t.timestamps
    end
  end
end
