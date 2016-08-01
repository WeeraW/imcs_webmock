class Distributor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # include DeviseTokenAuth::Concerns::User
  include Validator::CitizensId::Th
  # Include default devise modules. , :omniauthable :rememberable :confirmable :registerable, :recoverable,
  devise  :database_authenticatable,
          :trackable,
          :validatable,
          authentication_keys: [:distributor_code]

  # before_save -> { skip_confirmation! }
  before_save :generate_distributor_code, on: :create
  belongs_to :staff_creator, class_name: 'Staff', foreign_key: :staff_creator_id
  belongs_to :distributor_referror, class_name: 'Distributor', foreign_key: 'distributor_referror_id', optional: true

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

  def sponsor_at_upper_level(depth = 1)
    #Not implemented yet.
  end

  def distributor_referrees
    Distributor.where(distributor_referror_id: id)
  end

  def generate_distributor_code
    new_id = Distributor.any? ? Distributor.last.id + 1 : 0
    self.distributor_code = 'd' + '0' * (9 - new_id.to_s.length) + new_id.to_s
  end

  def have_sponsor?
    !distributor_referror.nil? && true
  end

  private

  def next_sponsor(referror, depth)
    point = Distributor.includes(:distributor_referror)
                       .where(distributor_referror_id: referror)
    if point.have_sponsor? && depth > 1
      next_sponsor
    end
  end
end
