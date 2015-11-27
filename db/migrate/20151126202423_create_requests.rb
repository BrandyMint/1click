class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :site
      t.string :email_or_phone

      t.timestamps null: false
    end
  end
end
