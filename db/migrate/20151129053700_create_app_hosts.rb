class CreateAppHosts < ActiveRecord::Migration
  def change
    create_table :app_hosts do |t|
      t.references :app, index: true, foreign_key: true
      t.string :host, null: false

      t.timestamps null: false
    end

    add_index :app_hosts, [:app_id, :host], unique: true
  end
end
