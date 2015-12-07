class CreateAppIdentifiedUsers < ActiveRecord::Migration
  def change
    create_table :app_identified_users do |t|
      t.references :app, index: true, foreign_key: true
      t.bigint :userId, null: false

      t.timestamps null: false
    end

    add_index :app_identified_users, [:app_id, :userId], unique: true
  end
end
