require 'rails_helper'

describe CustomField do
    describe 'data' do
        it 'is valid with empty json' do
            client =  Client.build(name: "Perchwell")
            building = Building.build(
                address_line_1: "379 W Broadway",
                city: "New York",
                state: "NY",
                zip: "10012",
                client: client
            )
            custom_field = CustomField.build(
                data: {},
                building: building
            )
            expect(custom_field).to be_valid
        end

        it 'is valid with non-nested json' do
            client =  Client.build(name: "Perchwell")
            building = Building.build(
                address_line_1: "379 W Broadway",
                city: "New York",
                state: "NY",
                zip: "10012",
                client: client
            )
            custom_field = CustomField.build(
                data: { construction_date: '1899' },
                building: building
            )
            expect(custom_field).to be_valid
        end

        it 'is valid when data is a string' do
            client =  Client.build(name: "Perchwell")
            building = Building.build(
                address_line_1: "379 W Broadway",
                city: "New York",
                state: "NY",
                zip: "10012",
                client: client
            )
            custom_field = CustomField.build(
                data: { construction_date: '1899' },
                building: building
            )
            expect(custom_field).to be_valid
        end

        it 'is valid when data is an integer' do
            client =  Client.build(name: "Perchwell")
            building = Building.build(
                address_line_1: "379 W Broadway",
                city: "New York",
                state: "NY",
                zip: "10012",
                client: client
            )
            custom_field = CustomField.build(
                data: { construction_date: 1899 },
                building: building
            )
            expect(custom_field).to be_valid
        end

        it 'is valid when data is a float' do
            client =  Client.build(name: "Perchwell")
            building = Building.build(
                address_line_1: "379 W Broadway",
                city: "New York",
                state: "NY",
                zip: "10012",
                client: client
            )
            custom_field = CustomField.build(
                data: { number_of_baths: 2.5 },
                building: building
            )
            expect(custom_field).to be_valid
        end

        it 'is valid when data is an array of strings' do
            client =  Client.build(name: "Perchwell")
            building = Building.build(
                address_line_1: "379 W Broadway",
                city: "New York",
                state: "NY",
                zip: "10012",
                client: client
            )
            custom_field = CustomField.build(
                data: { bedroom_colors: [ 'red', 'green', 'blue' ] },
                building: building
            )
            expect(custom_field).to be_valid
        end

        it 'is invalid when data is nested json' do
            client =  Client.build(name: "Perchwell")
            building = Building.build(
                address_line_1: "379 W Broadway",
                city: "New York",
                state: "NY",
                zip: "10012",
                client: client
            )
            custom_field = CustomField.build(
                data: { bedroom_colors: { main_bedroom: 'red', guest_bedroom: 'blue' } },
                building: building
            )
            expect(custom_field).to be_invalid
        end

        it 'is invalid when data is not a number, a string, or an array of strings' do            client =  Client.build(name: "Perchwell")
            building = Building.build(
                address_line_1: "379 W Broadway",
                city: "New York",
                state: "NY",
                zip: "10012",
                client: client
            )
            custom_field1 = CustomField.build(
                data: { has_balcony: true },
                building: building
            )
            custom_field2 = CustomField.build(
                data: { possible_subdivisions: [ 1, 2, 3 ] },
                building: building
            )
            expect(custom_field1).to be_invalid
            expect(custom_field2).to be_invalid
        end
    end
end
