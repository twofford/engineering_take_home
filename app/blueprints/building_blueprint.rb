class BuildingBlueprint < Blueprinter::Base
    fields :address_line_1, :address_line_2, :city, :state, :zip
    association :custom_fields, blueprint: CustomFieldBlueprint
end
