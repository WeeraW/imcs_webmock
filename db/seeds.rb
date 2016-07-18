# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Warehouse::FacilityType.create! id: 0, code: 'UNIDENTIFIED', display_name: 'UNIDENTIFIED'
Warehouse::Facility.create! id: 0, code: 'UNIDENTIFIED', display_name: 'UNIDENTIFIED'
