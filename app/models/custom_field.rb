# == Schema Information
#
# Table name: custom_fields
#
#  id          :bigint           not null, primary key
#  data        :jsonb            not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  building_id :bigint           not null
#
class CustomField < ApplicationRecord
    belongs_to :building

    validate :valid_json

    def valid_json
        return if data == {}
        errors.add("Data must be a JSON object with only one key") if data.keys.count > 1
        value = data[data.keys.first]
        errors.add("The value of Data must be a number, a string, or an array of strings") unless value.is_a?(Integer) || value.is_a?(Float) || value.is_a?(String) || (value.is_a?(Array) && value.all? { |el| el.is_a?(String) })
    end
end
