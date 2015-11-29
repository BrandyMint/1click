class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :account, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :role, null: false, default: :guest

      t.timestamps null: false
    end

    add_index :memberships, [:account_id, :user_id], unique: true
  end
end
