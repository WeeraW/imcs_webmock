class Distributor < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  # Include default devise modules. , :omniauthable :rememberable :confirmable :registerable, :recoverable,
  devise  :database_authenticatable,
          :trackable,
          :validatable,
          authentication_keys: [:distributor_code]

  before_validation :distributor_code, on: :create

  belongs_to :staff
  belongs_to :distributor_referror, class_name: 'Distributor', foreign_key: 'distributor_referror_id'

  validates :distributor_code,
            length: { is: 10 },
            format: { with: /\AD[0-9]{9}\z/i },
            presence: true,
            on: :create
  validates :first_name,
            :last_name,
            length: 1..150,
            presence: true,
            on: [:create, :update]
  validates :citizens_id,
            presence: true,
            format: /\A[0-9]{13}\z/,
            uniqueness: { case_sensitive: false },
            length: { is: 13 }
  validates :date_of_birth,
            presence: true
  validate :thai_citizens_id

  def thai_citizens_id
    if citizens_id.present?
      unless thai_citizens_id_checksum(citizens_id)
        errors.add(:citizens_id, 'ID is invalid')
      end
    end
  end

  def generate_distributetor_code
    new_id = last.id + 1
    self.distributor = 'd' + '0' * (9 - new_id.to_s.length) + new_id.to_s
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
