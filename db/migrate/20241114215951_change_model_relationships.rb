class ChangeModelRelationships < ActiveRecord::Migration[7.2]
  def change
    remove_column :clients, :building_id, :bigint
    remove_column :buildings, :custom_field_id, :bigint
    add_reference :buildings, :client, null: false, foreign_key: true
    add_reference :custom_fields, :building, null: false, foreign_key: true
  end
end
