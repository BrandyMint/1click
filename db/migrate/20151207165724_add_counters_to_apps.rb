class AddCountersToApps < ActiveRecord::Migration
  def change
    add_column :apps, :app_user_sessions_count, :integer, null: false, default: 0
    add_column :apps, :app_user_visits_count, :integer, null: false, default: 0
    add_column :apps, :app_events_count, :integer, null: false, default: 0
    add_column :apps, :app_users_count, :integer, null: false, default: 0
    add_column :apps, :app_sessions_count, :integer, null: false, default: 0
    add_column :apps, :app_page_events_count, :integer, null: false, default: 0
    add_column :apps, :app_identifies_count, :integer, null: false, default: 0
    add_column :apps, :app_identified_users_count, :integer, null: false, default: 0
    add_column :apps, :app_visits_count, :integer, null: false, default: 0
    add_column :apps, :app_pages_count, :integer, null: false, default: 0
  end
end
