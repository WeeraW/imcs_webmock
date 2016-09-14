class Freight::Provider < ApplicationRecord
  validates :name,
            presence: true
  validates :telephone_number,
            :fax_number,
            format: {
              with: /\A\+?\*?\#?[0-9]{3,}\z/i,
              allow_blank: true
            }
end
