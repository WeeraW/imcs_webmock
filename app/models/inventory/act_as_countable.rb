class Inventory::ActAsCountable < ApplicationRecord
  belongs_to :countable, polymorphic: true
  belongs_to :inventory_countable_unit, class_name: 'Inventory::CountableUnit', foreign_key: :inventory_countable_unit_id
end
