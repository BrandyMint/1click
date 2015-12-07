class CreateAppIdentifies < ActiveRecord::Migration
  def change
    create_table :app_identifies do |t|
      t.references :app, index: true, foreign_key: true
      t.string :email
      t.string :handle, null: false
      t.string :sessionId, null: false
      t.string :visitId, null: false
      t.string :userId, null: false

      t.timestamps null: false
    end

    add_index :app_identifies, [:app_id, :handle], unique: true
    add_index :app_identifies, [:app_id, :email], unique: true
  end
end
