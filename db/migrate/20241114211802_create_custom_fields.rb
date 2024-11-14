class CreateCustomFields < ActiveRecord::Migration[7.2]
  def change
    create_table :custom_fields do |t|
      t.string :name, null: false
      t.jsonb :value, default: {}, null: false
      t.timestamps
    end
  end
end
