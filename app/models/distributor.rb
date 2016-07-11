class Distributor < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  include Validator::CitizensId::Th
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

  def generate_distributetor_code
    new_id = last.id + 1
    self.distributor = 'd' + '0' * (9 - new_id.to_s.length) + new_id.to_s
  end
end
