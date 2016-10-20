class AddIsoIndexToGeoCountry < ActiveRecord::Migration[5.0]
  def change
    add_index :geo_countries, :iso_3166_a3_code, unique: true
    add_index :geo_countries, :iso_3166_n_code, unique: true
    add_index :geo_countries, :itu_t_tel_code
  end
end
