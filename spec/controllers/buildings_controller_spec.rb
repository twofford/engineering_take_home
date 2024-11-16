require "rails_helper"

describe BuildingsController, type: :request do
    describe "#index" do
        it "returns buildings" do
            create_list(:building, 5)
            get buildings_path
            body = JSON.parse(response.body)
            expect(response.status).to eq(200)
            expect(body.count).to eq(5)
        end

        it "returns associated custom fields" do
            create(:custom_field, building: create(:building), data: { bedroom_color: 'white' })
            get buildings_path
            body = JSON.parse(response.body)
            expect(response.status).to eq(200)
            expect(body.first["custom_fields"].first.dig("data", "bedroom_color")).to eq("white")
        end

        it "returns no more than 100 buildings" do
            params = { options: { limit: 500 } }
            create_list(:building, 101)
            get buildings_path, params: params
            body = JSON.parse(response.body)
            expect(response.status).to eq(200)
            expect(body.count).to eq(100)
        end

        it "respects limit param if 100 or less" do
            params = { options: { limit: 50 } }
            create_list(:building, 51)
            get buildings_path, params: params
            body = JSON.parse(response.body)
            expect(response.status).to eq(200)
            expect(body.count).to eq(50)
        end

        it "respects offset param" do
            params = { options: { limit: 1, offset: 1 } }
            create(:building, address_line_2: "Apt 1")
            create(:building, address_line_2: "Apt 2")
            get buildings_path, params: params
            body = JSON.parse(response.body)
            expect(response.status).to eq(200)
            expect(body.count).to eq(1)
            expect(body.first["address_line_2"]).to eq("Apt 2")
        end
    end
end
