class CreateAppUserIdentifies < ActiveRecord::Migration
  def change
    create_table :app_user_identifies do |t|
      t.references :app, index: true, foreign_key: true
      t.bigint :visitUserId, null: false
      t.bigint :handledUserId, null: false

      t.timestamps null: false
    end

    add_index :app_user_identifies, [:app_id, :visitUserId], unique: true
  end
end
