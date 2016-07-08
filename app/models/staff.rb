class Staff < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  # Include default devise modules. :confirmable, :omniauthable :registerable, :recoverable,
  devise  :database_authenticatable,
          :rememberable,
          :trackable,
          :validatable

  has_many :distributors, dependent: :restrict_with_exception

  validates :first_name,
            :last_name,
            :staff_account,
            presence: true
  validates :email,
            uniqueness: { case_sensitive: false }
  validates :employee_code,
            :staff_account,
            uniqueness: true,
            presence: true
end
