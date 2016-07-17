class Inventory::CountableUnit < ApplicationRecord
  has_many :act_as_countables, class_name: 'Inventory::ActAsCountable', foreign_key: :inventory_countable_unit_id
end
