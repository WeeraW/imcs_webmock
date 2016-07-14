namespace :imcs do
  desc 'Drop messed database and recreate again'
  task reset_db: [:environment, 'db:drop', 'db:create', 'db:migrate'] do
    puts 'IMCS: Reset database!!'
  end

  desc 'Reset database and seed data'
  task reset_db_and_seed: [:environment, :reset_db, 'db:seed'] do
    puts 'IMCS: Seed database!!'
  end

end
