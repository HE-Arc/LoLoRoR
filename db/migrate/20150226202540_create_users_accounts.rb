class CreateUsersAccounts < ActiveRecord::Migration
  def change
    create_table :users_accounts, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :account, index: true
    end
  end
end
