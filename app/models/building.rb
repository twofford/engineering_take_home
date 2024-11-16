# == Schema Information
#
# Table name: buildings
#
#  id             :bigint           not null, primary key
#  address_line_1 :string           not null
#  address_line_2 :string
#  state          :string           not null
#  zip            :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  client_id      :bigint           not null
#  city           :string           not null
#
class Building < ApplicationRecord
    STATES ||= [
        "AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA",
        "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD",
        "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ",
        "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC",
        "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"
    ].freeze

    NUMS ||= [ "0", "1", "2", "3", "4", "5", "6", "7", "8", "9" ].freeze

    belongs_to :client
    has_many :custom_fields, dependent: :destroy

    validates :address_line_1, :state, :city, :zip, presence: true
    validates :state, inclusion: { in: STATES, message: "%{value} is not a US state" }
    validate :valid_zip

    def valid_zip
        errors.add("Zip must be 5 digits or 9 digits") unless [ 5, 9 ].include?(zip.length)
        errors.add("Zip must contain only numbers") unless zip.chars.all? { |char| NUMS.include?(char) }
    end
end
