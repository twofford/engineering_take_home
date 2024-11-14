class AddForeignKeys < ActiveRecord::Migration[7.2]
  def change
    add_reference :buildings, :custom_field, null: false, foreign_key: true
    add_reference :clients, :building, null: false, foreign_key: true
  end
end
