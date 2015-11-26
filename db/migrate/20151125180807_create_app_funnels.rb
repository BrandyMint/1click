class CreateAppFunnels < ActiveRecord::Migration
  def change
    create_table :app_funnels do |t|
      t.references :app, index: true, foreign_key: true, null: false
      t.string :title, null: false

      t.timestamps null: false
    end
  end
end
