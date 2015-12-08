class AddHandledUserIdToAppIdentifies < ActiveRecord::Migration
  def change
    add_column :app_identifies, :handledUserId, :bigint, null: false

    drop_table :app_user_identifies
  end
end
