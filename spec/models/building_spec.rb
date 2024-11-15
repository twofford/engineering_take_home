require 'rails_helper'

describe Building do
    describe 'state' do
        it 'is valid with a valid US state' do
            client =  Client.build(name: "Perchwell")
            building = Building.build(
                address_line_1: "379 W Broadway",
                city: "New York",
                state: "NY",
                zip: "10012",
                client: client
            )
            expect(building).to be_valid
        end

        it 'is invalid with an invalid US state' do
            client =  Client.build(name: "Perchwell")
            building = Building.build(
                address_line_1: "379 W Broadway",
                city: "New York",
                state: "New York",
                zip: "10012",
                client: client
            )
            expect(building).to be_invalid
        end
    end

    describe 'zip' do
        it 'is valid with a 5 digit zip code' do
            client =  Client.build(name: "Perchwell")
            building = Building.build(
                address_line_1: "379 W Broadway",
                city: "New York",
                state: "NY",
                zip: "10012",
                client: client
            )
            expect(building).to be_valid
        end

        it 'is valid with a 9 digit zip code' do
            client =  Client.build(name: "Perchwell")
            building = Building.build(
                address_line_1: "379 W Broadway",
                city: "New York",
                state: "NY",
                zip: "100121234",
                client: client
            )
            expect(building).to be_valid
        end

        it 'is invalid without a 5 or 9 digit zip code' do
            client =  Client.build(name: "Perchwell")
            building = Building.build(
                address_line_1: "379 W Broadway",
                city: "New York",
                state: "NY",
                zip: "123",
                client: client
            )
            expect(building).to be_invalid
        end
    end
end
