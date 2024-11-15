class MakeBuildingsCityNotNullable < ActiveRecord::Migration[7.2]
  def change
    change_column_null :buildings, :city, false
  end
end
