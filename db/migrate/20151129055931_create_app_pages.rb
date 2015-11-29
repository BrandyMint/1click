class CreateAppPages < ActiveRecord::Migration
  def change
    create_table :app_pages do |t|
      t.references :app, index: true, foreign_key: true
      t.string :host, null: false
      t.string :path, null: false, default: '/'

      t.timestamps null: false
    end

    add_index :app_pages, [:app_id, :host, :path], unique: true
  end
end
