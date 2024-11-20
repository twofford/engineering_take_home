class BuildingBlueprint < Blueprinter::Base
    identifier :id
    fields :address_line_1, :address_line_2, :city, :state, :zip
    association :custom_fields, blueprint: CustomFieldBlueprint
    association :client, blueprint: ClientBlueprint
end
