class Staff < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # include DeviseTokenAuth::Concerns::User
  # Include default devise modules. :confirmable, :omniauthable :registerable, :recoverable,
  attr_accessor :login, :modorator, :sale, :accountant, :warehouse
  devise  :database_authenticatable,
          :rememberable,
          :trackable,
          :validatable,
          authentication_keys: [:login]

  has_many :created_distributors, class_name: 'Distributor', foreign_key: :staff_creator_id, dependent: :restrict_with_exception

  has_many :created_orders, class_name: 'Order::Order', foreign_key: :create_by_staff_id, inverse_of: :create_by

  validates :first_name,
            :last_name,
            presence: true

  validates :employee_code,
            :staff_account,
            presence: true,
            uniqueness: true,
            format: { with: /\A[a-zA-Z0-9_\.]*\z/, multiline: true }

  validates :staff_account,
            presence: true,
            uniqueness: { case_sensitive: false }

  def login=(login)
    @login = login
  end

  def login
    @login || self.staff_account || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(staff_account) = :value OR lower(email) = :value", { value: login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
end
