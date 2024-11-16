require 'rails_helper'

describe Building do
    describe 'state' do
        it 'is valid with a valid US state' do
            building = build(:building, state: "NY")
            expect(building).to be_valid
        end

        it 'is invalid with an invalid US state' do
            building = build(:building, state: "FOO")
            expect(building).to be_invalid
        end
    end

    describe 'zip' do
        it 'is valid with a 5 digit zip code' do
            building = build(:building, zip: "10012")
            expect(building).to be_valid
        end

        it 'is valid with a 9 digit zip code' do
            building = build(:building, zip: "100121234")
            expect(building).to be_valid
        end

        it 'is invalid without a 5 or 9 digit zip code' do
            building = build(:building, zip: "123")
            expect(building).to be_invalid
        end
    end
end
