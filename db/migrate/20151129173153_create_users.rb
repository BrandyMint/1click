class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone
      t.string :email

      t.string :pin_code, null: false
      t.string :phone_confirmed, :string
      t.timestamp :phone_confirmed_at


      t.string :email_confirmed, :string
      t.timestamp :email_confirmed_at


      t.timestamps null: false
    end

    add_index :users, :phone, unique: true
    add_index :users, :email, unique: true
  end
end
