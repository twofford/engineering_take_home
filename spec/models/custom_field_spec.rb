require 'rails_helper'

describe CustomField do
    describe 'data' do
        it 'is valid with empty json' do
            custom_field = build(:custom_field, data: {})
            expect(custom_field).to be_valid
        end

        it 'is valid with non-nested json' do
            custom_field = build(:custom_field, data: { construction_date: '1899' })
            expect(custom_field).to be_valid
        end

        it 'is valid when data is a string' do
            custom_field = build(:custom_field, data: { bedroom_color: 'blue' })
            expect(custom_field).to be_valid
        end

        it 'is valid when data is an integer' do
            custom_field = build(:custom_field, data: { construction_date: 1899 })
            expect(custom_field).to be_valid
        end

        it 'is valid when data is a float' do
            custom_field = build(:custom_field, data: { number_of_bathrooms: 2.5 })
            expect(custom_field).to be_valid
        end

        it 'is valid when data is an array of strings' do
            custom_field = build(:custom_field, data: { bedroom_colors: [ 'red', 'green', 'blue' ] })
            expect(custom_field).to be_valid
        end

        it 'is invalid when data is nested json' do
            custom_field = build(:custom_field, data: { bedroom_colors: { main_bedroom: 'red', guest_bedroom: 'blue' } })
            expect(custom_field).to be_invalid
        end

        it 'is invalid when data is not a number, a string, or an array of strings' do
            custom_field1 = build(:custom_field, data: { has_balcony: true })
            custom_field2 = build(:custom_field, data: { possible_subdivisions: [ 1, 2, 3 ] })
            expect(custom_field1).to be_invalid
            expect(custom_field2).to be_invalid
        end
    end
end
