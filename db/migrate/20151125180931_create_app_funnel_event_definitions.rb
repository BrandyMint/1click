class CreateAppFunnelEventDefinitions < ActiveRecord::Migration
  def change
    create_table :app_funnel_event_definitions do |t|
      t.references :app_funnel, index: true, foreign_key: true, null: false
      t.references :event_definition, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
