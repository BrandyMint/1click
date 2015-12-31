class RemoveIndexFromAppUserIdentifies < ActiveRecord::Migration
  def change

    # Удаляем уникальность
    remove_index "app_user_identifies", name: "index_app_user_identifies_on_app_id_and_visitUserId"
    add_index "app_user_identifies", ["app_id", "visitUserId"]


    remove_index "app_identified_users", name: "index_app_identified_users_on_app_id_and_userId"
    add_index "app_identified_users", ["app_id", "userId"]
  end
end
