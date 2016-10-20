namespace :imcs do
  desc 'Drop messed database and recreate again'
  task reset_db: [:environment, 'db:drop', 'db:create', 'db:migrate'] do
    puts 'IMCS: Reset database!!'
  end

  desc 'Reset database and seed data'
  task reset_db_and_seed: [:environment, :reset_db, 'db:seed'] do
    puts 'IMCS: Seed database!!'
  end

  namespace :data do
    desc 'Destroy all data seed Geo::Country data'
    namespace :seed do
      task geo_country: [:environment] do
        require 'csv'
        Geo::Country.destroy_all
        File.open(Rails.root.to_s + '/db/data/geo_country.csv', 'r') do |file|
          csv = CSV.new(file, headers: true)
          while row = csv.shift
            p row
            Geo::Country.create! row.to_h
          end
        end
      end
    end
  end

end
