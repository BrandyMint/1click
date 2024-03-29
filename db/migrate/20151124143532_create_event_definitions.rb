class CreateEventDefinitions < ActiveRecord::Migration
  def change
    create_table :event_definitions do |t|
      t.references :app,             null: false
      t.string    :title,           null: false
      t.string    :event_type,      null: false
      t.string    :element_classes, default: nil, array: true
      t.string    :element_tag
      t.string    :element_id
      t.string    :href
      t.string    :inner_text
      t.string    :dom_path,        default: nil, array: true
      t.integer   :events_count, null: false, default: 0

      t.timestamps null: false
    end

    add_column :apps, :event_definitions_count, :integer, null: false, default: 0
  end
end
