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
        errors.add(:base, "Error creating Custom Field. Data must not be nested. Data: #{data}.") if data.any? { |_, value| value.is_a?(Hash) }
        value = data[data.keys.first]
        errors.add(:base, "Error creating Custom Field. Data must be a number, a string, or an array of strings. Data: #{value.is_a?(Array) ? "Array of #{value.map { |el| el.class }.uniq.join(", ") }" : value.class}") unless value.is_a?(Integer) || value.is_a?(Float) || value.is_a?(String) || (value.is_a?(Array) && value.all? { |el| el.is_a?(String) })
    end
end
