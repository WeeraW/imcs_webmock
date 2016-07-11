require 'active_support/concern'

module Validator::CitizensId::Th
  extend ActiveSupport::Concern
  included do
    def thai_citizens_id
      if citizens_id.present?
        unless thai_citizens_id_checksum(citizens_id)
          errors.add(:citizens_id, 'ID is invalid')
        end
      end
    end

    private

    def thai_citizens_id_checksum(citizens_id)
      parity, digits = thai_citizens_id_to_parity_and_array_digits citizens_id
      sum = thai_citizens_id_digits_sum thai_convert_to_pairs_coefficient_and_digit(digits)
      sum_mod = sum % 11
      if sum_mod <= 1
        parity.eql?(1 - sum_mod)
      else
        parity.eql?(11 - sum_mod)
      end
    end

    # @return parity: Integer, checksum_digit: Hash
    def thai_citizens_id_to_parity_and_array_digits(citizens_id)
      digits = citizens_id.split(//).collect(&:to_i)
      return digits.pop, digits
    end

    def thai_convert_to_pairs_coefficient_and_digit(digits)
      digit_pairs = {}
      digits.each_with_index { |e, i| digit_pairs.store(13 - i, e) }
      digit_pairs
    end

    def thai_citizens_id_digits_sum(digit_pairs)
      sum = 0
      digit_pairs.each_pair { |name, val| sum += name * val }
      sum
    end
  end
end
