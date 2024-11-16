FactoryBot.define do
    factory :client do
        name { "Perchwell" }
    end

    factory :building do
        address_line_1 { "379 W Broadway" }
        city { "New York" }
        state { "NY" }
        zip { "10012" }
        client { create(:client) }
    end

    factory :custom_field do
        building { create(:building) }
    end
end
