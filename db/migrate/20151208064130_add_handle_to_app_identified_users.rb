class AddHandleToAppIdentifiedUsers < ActiveRecord::Migration
  def change
    add_column :app_identified_users, :handle, :string, null: false

    add_index :app_identified_users, [:app_id, :handle], unique: true
  end
end
