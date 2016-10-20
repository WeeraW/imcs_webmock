class AddIsoAddionalAttrToGeoCountry < ActiveRecord::Migration[5.0]
  def change
    add_column :geo_countries, :iso_3166_a3_code, :string
    add_column :geo_countries, :iso_3166_n_code, :string
    add_column :geo_countries, :itu_t_tel_code, :string
  end
end
