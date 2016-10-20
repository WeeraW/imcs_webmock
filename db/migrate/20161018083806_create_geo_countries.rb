class CreateGeoCountries < ActiveRecord::Migration[5.0]
  def change
    create_table :geo_countries do |t|
      t.string :iso_3166_a2_code
      t.string :display_text_en

      t.timestamps
    end
    add_index :geo_countries, :iso_3166_a2_code, unique: true
    add_index :geo_countries, :display_text_en, unique: true
  end
end
