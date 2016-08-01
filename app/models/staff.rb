class Staff < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # include DeviseTokenAuth::Concerns::User
  # Include default devise modules. :confirmable, :omniauthable :registerable, :recoverable,
  devise  :database_authenticatable,
          :rememberable,
          :trackable,
          :validatable

  # before_save -> { skip_confirmation! }

  has_many :created_distributors, class_name: 'Distributor', foreign_key: :staff_creator_id, dependent: :restrict_with_exception

  validates :first_name,
            :last_name,
            presence: true

  validates :employee_code,
            :staff_account,
            uniqueness: { case_sensitive: false },
            presence: true
end
