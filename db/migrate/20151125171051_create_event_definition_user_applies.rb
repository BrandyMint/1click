class CreateEventDefinitionUserApplies < ActiveRecord::Migration
  def change
    create_table :event_definition_user_applies do |t|
      t.references :event_definition, null: false
      t.references :app, null: false
      t.references :app_page_event, null: false
      t.timestamp :time, null: false
      t.bigint :userId, null: false

      t.timestamps null: false
    end

    add_index :event_definition_user_applies, [:event_definition_id, :userId], unique: true, name: :edua_uniq

    add_column :event_definitions, :users_count, :integer, null: false, default: 0
  end
end
