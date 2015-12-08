class AddEmailToAppIdentifiedUser < ActiveRecord::Migration
  def change
    add_column :app_identified_users, :email, :string
    remove_index "app_identifies", ["app_id", "email"]
    remove_index "app_identifies", ["app_id", "handle"]
  end
end
