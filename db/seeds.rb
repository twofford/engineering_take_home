# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

clients = []
buildings = []

10.times do
  client = Client.new(name: Faker::Name.name)
  if client.save
    print "."
    clients << client
  else
    print "!"
  end
end

clients.each do |client|
  5.times do
    building = Building.new(
      address_line_1: Faker::Address.street_address,
      address_line_2: Faker::Address.secondary_address,
      city: Faker::Address.city,
      state: Faker::Address.state_abbr,
      zip: Faker::Address.zip_code(state_abbreviation: "NY"),
      client: client
    )
    if building.save
      print "."
      buildings << building
    else
      print "!"
    end
  end
end

buildings.each do |building|
  custom_field1 = CustomField.new(building: building, data: { bedroom_color: Faker::Color.color_name })
  custom_field2 = CustomField.new(building: building, data: { number_of_bathrooms: [ 1, 2, 3, 4, 5 ].sample })
  if custom_field1.save
    print "."
  else
    print "!"
  end

  if custom_field2.save
    print "."
  else
    print "!"
  end
end
