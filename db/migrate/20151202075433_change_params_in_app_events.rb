class ChangeParamsInAppEvents < ActiveRecord::Migration
  def change
    rename_column :app_events, :params, :query
    change_column :app_events, :query, :string, null: false
  end
end
