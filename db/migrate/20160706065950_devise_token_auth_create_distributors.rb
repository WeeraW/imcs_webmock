class DeviseTokenAuthCreateDistributors < ActiveRecord::Migration[5.0]
  def change
    create_table(:distributors) do |t|
      ## Required
      # t.string :provider, null: false, default: 'email'
      # t.string :uid, null: false, default: ''

      ## Database authenticatable
      t.string :encrypted_password, null: false, default: ''

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, :default => 0, :null => false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## User Info
      t.string :distributor_code, null: false
      t.integer :distributor_referror_id
      t.string :first_name, null: false
      t.string :middle_name
      t.string :last_name, null: false
      t.date :date_of_birth
      t.string :nickname, limit: 40
      t.string :citizens_id, null: false
      t.string :email
      t.text :address
      t.string :district
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :telephone_number
      t.string :mobile_number
      t.string :active, null: false, default: true

      ## Tokens
      t.json :tokens

      t.timestamps
    end

    add_index :distributors, [:id, :distributor_referror_id], unique: true, name: :index_distributor_sponsor
    add_index :distributors, :distributor_code, unique: true
    add_index :distributors, :email, unique: true
    # add_index :distributors, [:uid, :provider],     unique: true
    add_index :distributors, :reset_password_token, unique: true
    # add_index :distributors, :confirmation_token,   :unique => true
    # add_index :distributors, :unlock_token,         :unique => true
  end
end
