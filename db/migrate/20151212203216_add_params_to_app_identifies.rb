class AddParamsToAppIdentifies < ActiveRecord::Migration
  def change
    add_column :app_identifies, :data, :hstore, null: false, default: {}
    add_column :app_identified_users, :data, :hstore, null: false, default: {}
  end
end
