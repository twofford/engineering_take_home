# == Schema Information
#
# Table name: clients
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Client < ApplicationRecord
    has_many :buildings, dependent: :destroy

    validates :name, presence: true
end
