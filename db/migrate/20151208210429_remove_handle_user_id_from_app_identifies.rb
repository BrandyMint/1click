class RemoveHandleUserIdFromAppIdentifies < ActiveRecord::Migration
  def change
    remove_column :app_identifies, :handledUserId
  end
end
