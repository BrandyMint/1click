class CreateEventApplies < ActiveRecord::Migration
  def change
    create_table :event_applies do |t|
      t.references :app, null: false
      t.references :event_definition, null: false
      t.references :app_page_event, null: false
      t.timestamp :time, null: false

      t.timestamps null: false
    end
  end
end
