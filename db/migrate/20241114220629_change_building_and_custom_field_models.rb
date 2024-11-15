class ChangeBuildingAndCustomFieldModels < ActiveRecord::Migration[7.2]
  def change
    add_column :buildings, :city, :string
    remove_column :custom_fields, :name, :string
    rename_column :custom_fields, :value, :data
  end
end
