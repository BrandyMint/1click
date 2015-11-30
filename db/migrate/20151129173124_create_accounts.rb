class CreateAccounts < ActiveRecord::Migration
  def up
    create_table :accounts do |t|
      t.string :host, null: false

      t.timestamps null: false
    end

    add_column :apps, :account_id, :integer

    account = Account.create! host: 'test'

    App.update_all account_id: account.id

    change_column :apps, :account_id, :integer, null: false
  end

  def down
    drop_table :accounts
  end
end
