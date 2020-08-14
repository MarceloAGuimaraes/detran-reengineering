# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :name, null: false
      t.string :cpf, null: false
      t.date :birth_date, null: false
      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      # t.inet     :current_sign_in_ip
      # t.inet     :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end
    create_table :licenses do |t|
      t.integer :cnh_type, null: false
      t.string :cnh_number, null: false
      t.date :first_cnh_date, null: false
      t.belongs_to :user, index: true
    end
    create_table :vehicles do |t|
      t.string :plate, null: false
      t.string :chassi, null: false
      t.string :renavam, null: false
      t.belongs_to :user, index: true
    end
    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :vehicles, :plate, unique: true
    add_index :vehicles, :chassi, unique: true
  end
end
