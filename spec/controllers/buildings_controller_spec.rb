require "rails_helper"

describe BuildingsController, type: :request do
    describe "#index" do
        it "returns all buildings" do
            create_list(:building, 5)
            get buildings_path
            body = JSON.parse(response.body)
            expect(response.status).to eq(200)
            expect(body["buildings"].count).to eq(5)
            expect(body["meta"]["total"]).to eq(5)
        end

        it "paginates the results when passed a `page` param" do
          create_list(:building, 5)
          create(:building, address_line_1: "1337 Foo Lane")
          params = { page: 2 }
          get buildings_path, params: params
          body = JSON.parse(response.body)
          expect(body["buildings"].count).to eq(1)
          expect(body["buildings"].first["address_line_1"]).to eq("1337 Foo Lane")
        end

        it "returns the first 5 results when not passed a `page` param" do
            create_list(:building, 5)
            create(:building, address_line_1: "1337 Foo Lane")
            get buildings_path
            body = JSON.parse(response.body)
            expect(body["buildings"].count).to eq(5)
            expect(body["buildings"].first["address_line_1"]).to eq("379 W Broadway")
        end

        it "returns associated custom fields" do
            building = create(:building)
            create(:custom_field, building: building, data: { bedroom_color: 'white' })
            create(:custom_field, building: building, data: { number_of_bathrooms: 3 })
            get buildings_path
            body = JSON.parse(response.body)
            expect(response.status).to eq(200)
            expect(body["buildings"].first["custom_fields"].count).to eq(2)
            expect(body["buildings"].first["custom_fields"].first.dig("data", "bedroom_color")).to eq("white")
            expect(body["buildings"].first["custom_fields"].second.dig("data", "number_of_bathrooms")).to eq(3)
        end
    end

    describe "#create" do
        it "creates and returns new buildings" do
            params = { building: { address_line_1: "1337 Foo Lane", city: "New York", state: "NY", zip: "10012", client_id: create(:client).id } }
            expect { post buildings_path, params: params }.to change(Building, :count).by(1)
            body = JSON.parse(response.body)
            expect(response.status).to eq(200)
            expect(body["address_line_1"]).to eq("1337 Foo Lane")
            expect(body["client"]["name"]).to eq("Perchwell")
        end

        it "returns a 422 error if passed no params" do
            expect { post buildings_path }.to not_change(Building, :count).and not_change(CustomField, :count)
            body = JSON.parse(response.body)
            expect(response.status).to eq(422)
            expect(body["errors"]).to include("param is missing or the value is empty: building")
        end

        it "creates and returns associated custom fields" do
            params = { building: { address_line_1: "1337 Foo Lane", city: "New York", state: "NY", zip: "10012", client_id: create(:client).id, custom_fields: { number_of_bedrooms: 3, number_of_bathrooms: 2.5 } } }
            expect { post buildings_path, params: params }.to change(Building, :count).by(1).and change(CustomField, :count).by(2)
            body = JSON.parse(response.body)
            expect(response.status).to eq(200)
            expect(body["address_line_1"]).to eq("1337 Foo Lane")
            expect(body["custom_fields"].first.dig("data", "number_of_bedrooms")).to eq("3")
            expect(body["custom_fields"].second.dig("data", "number_of_bathrooms")).to eq("2.5")
        end

        it "accepts strings for custom field values" do
            params = { building: { address_line_1: "1337 Foo Lane", city: "New York", state: "NY", zip: "10012", client_id: create(:client).id, custom_fields: { bedroom_color: "white" } } }
            expect { post buildings_path, params: params }.to change(Building, :count).by(1).and change(CustomField, :count).by(1)
            body = JSON.parse(response.body)
            expect(response.status).to eq(200)
            expect(body["address_line_1"]).to eq("1337 Foo Lane")
            expect(body["custom_fields"].first.dig("data", "bedroom_color")).to eq("white")
        end

        it "accepts integers for custom field values" do
            params = { building: { address_line_1: "1337 Foo Lane", city: "New York", state: "NY", zip: "10012", client_id: create(:client).id, custom_fields: { number_of_bedrooms: 2 } } }
            expect { post buildings_path, params: params }.to change(Building, :count).by(1).and change(CustomField, :count).by(1)
            body = JSON.parse(response.body)
            expect(response.status).to eq(200)
            expect(body["address_line_1"]).to eq("1337 Foo Lane")
            expect(body["custom_fields"].first.dig("data", "number_of_bedrooms")).to eq("2")
        end

        it "accepts floats for custom field values" do
            params = { building: { address_line_1: "1337 Foo Lane", city: "New York", state: "NY", zip: "10012", client_id: create(:client).id, custom_fields: { number_of_bathrooms: 2.5 } } }
            expect { post buildings_path, params: params }.to change(Building, :count).by(1).and change(CustomField, :count).by(1)
            body = JSON.parse(response.body)
            expect(response.status).to eq(200)
            expect(body["address_line_1"]).to eq("1337 Foo Lane")
            expect(body["custom_fields"].first.dig("data", "number_of_bathrooms")).to eq("2.5")
        end

        it "accepts arrays of strings for custom field values" do
            params = { building: { address_line_1: "1337 Foo Lane", city: "New York", state: "NY", zip: "10012", client_id: create(:client).id, custom_fields: { bedroom_color_options: [ "red", "blue", "green" ] } } }
            expect { post buildings_path, params: params }.to change(Building, :count).by(1).and change(CustomField, :count).by(1)
            body = JSON.parse(response.body)
            expect(response.status).to eq(200)
            expect(body["address_line_1"]).to eq("1337 Foo Lane")
            expect(body["custom_fields"].first.dig("data", "bedroom_color_options")).to include("red", "blue", "green")
        end

        it "does not accept hashes for custom field values" do
            params = { building: { address_line_1: "1337 Foo Lane", city: "New York", state: "NY", zip: "10012", client_id: create(:client).id, custom_fields: { bedroom_options: { furnished: true, max_bed_size: "queen" } } } }
            expect { post buildings_path, params: params }.to not_change(Building, :count).and not_change(CustomField, :count)
            body = JSON.parse(response.body)
            expect(response.status).to eq(422)
            expect(body["errors"]).to include(/Data must not be nested/)
        end

        it "does not allow sql injection" do
            params = { building: { address_line_1: "1337 Foo Lane'; DROP TABLE buildings; --", city: "New York", state: "NY", zip: "10012", client_id: create(:client).id, custom_fields: { bedroom_color_options: [ "red", "green', 'blue')--" ], number_of_bedrooms: "1; DROP TABLE buildings; --" } } }
            post buildings_path, params: params
            expect(Building.table_exists?).to eq(true)
        end

        it "creates buildings without custom fields" do
            params = { building: { address_line_1: "1337 Foo Lane", city: "New York", state: "NY", zip: "10012", client_id: create(:client).id } }
            expect { post buildings_path, params: params }.to change(Building, :count).by(1).and not_change(CustomField, :count)
            body = JSON.parse(response.body)
            expect(response.status).to eq(200)
            expect(body["address_line_1"]).to eq("1337 Foo Lane")
            expect(body["custom_fields"]).to be_empty
        end
    end

  describe "#update" do
    it "updates and returns existing buildings" do
        building = create(:building, address_line_1: "444 Bar Place")
        params = { building: { address_line_1: "1337 Foo Lane" } }
        patch building_path(building.id), params: params
        body = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(body["address_line_1"]).to eq("1337 Foo Lane")
        expect(building.reload.address_line_1).to eq("1337 Foo Lane")
    end

    it "returns a 404 error if the building does not exist" do
        params = { building: { address_line_1: "1337 Foo Lane" } }
        patch building_path(123), params: params
        body = JSON.parse(response.body)
        expect(response.status).to eq(404)
        expect(body["error"]).to eq("Building 123 not found")
    end

    it "updates and returns associated custom fields" do
        building = create(:building)
        custom_field = create(:custom_field, building: building, data: { bedroom_color: "white" })
        params = { building: { custom_fields: [ { id: custom_field.id, data: { bedroom_color: "blue" } } ] } }
        patch building_path(building.id), params: params
        body = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(body["custom_fields"].first.dig("data", "bedroom_color")).to eq("blue")
        expect(custom_field.reload.data["bedroom_color"]).to eq("blue")
    end

    it "returns a 422 error if an associated custom field doesn't exist" do
      params = { building: { custom_fields: [ { id: 123, data: { bedroom_color: "white" } } ] } }
      patch building_path(create(:building).id), params: params
      body = JSON.parse(response.body)
      expect(response.status).to eq(422)
      expect(body["errors"]).to include(/Couldn't find CustomField with 'id'=123/)
    end
  end
end
