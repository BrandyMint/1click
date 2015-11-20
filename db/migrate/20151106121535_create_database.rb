class CreateDatabase < ActiveRecord::Migration
  def change
    enable_extension "plpgsql"
    enable_extension "hstore"
    enable_extension "pg_trgm"
    enable_extension "intarray"

    create_table :apps do |t|
      t.timestamps null: false
    end

    create_table :app_users do |t|
      t.references :app, null: false
      t.bigint :userId, null: false
      t.integer :sessions_count, null: false, default: 0

      t.timestamps null: false
    end

    add_index :app_users, [:app_id, :userId]

    create_table :app_user_sessions do |t|
      t.references :app, null: false
      t.bigint :userId,    null: false
      t.bigint :sessionId, null: false
      t.integer :visits_count, null: false, default: 0

      t.string  :user_agent

      t.timestamps null: false
    end

    add_index :app_user_sessions, [:app_id, :userId, :sessionId]

    create_table :app_user_visits do |t|
      t.timestamp :time, null: false
      t.references :app, null: false
      t.bigint :userId,    null: false
      t.bigint :sessionId, null: false
      t.bigint :visitId,   null: false

      t.string :location_hash
      t.string :path, null: false
      t.string :query
      t.string :domain, null: false
      t.string :title
      t.string :referer
      t.string :referer_search_query
      t.string :utm_source
      t.string :utm_medium
      t.string :utm_term
      t.string :utm_content
      t.string :utm_campaign

      t.integer :events_count, null: false, default: 0

      t.timestamps null: false
    end

    add_index :app_user_visits,  [:app_id, :userId, :sessionId, :visitId], name: :app_user_visits_unique_index

    create_table :app_events do |t|
      t.references :app, null: false
      t.hstore :params
      t.string :user_agent

      t.timestamps null: false
    end

    create_table :app_inner_events do |t|
      t.timestamp :time, null: false
      t.references :app, null: false
      t.bigint :userId, null: false
      t.bigint :sessionId, null: false
      t.bigint :visitId, null: false

      t.string :event_type, null: false
      t.string :element_classes, array: true, default: [], null: false
      t.string :element_tag, null: false
      t.string :element_id
      t.string :href
      t.string :dom_path, array: true, default: [], null: false
      t.string :inner_text

      t.timestamps null: false
    end
  end
end
