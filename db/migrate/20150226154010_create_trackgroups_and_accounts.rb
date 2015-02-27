class CreateTrackgroupsAndAccounts < ActiveRecord::Migration
  def change
    
    create_table :trackgroups do |t|
      t.belongs_to :user, index: true
      t.string :name
      t.timestamps
    end
    
    create_table :accounts do |t|
      t.string :pseudoLoL
      t.integer :idLoL

      t.timestamps
    end
    
    create_table :trackgroups_accounts, id: false do |t|
      t.belongs_to :trackgroup, index: true
      t.belongs_to :account, index: true
    end
    
  end
end
