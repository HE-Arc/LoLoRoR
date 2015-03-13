class CreateMatchHistoryModules < ActiveRecord::Migration
  def change
    create_table :match_history_modules do |t|
      t.belongs_to :dashboard, index: true
      t.belongs_to :account, index: true
      t.integer :nb_match
      
      t.timestamps
    end
  end
end
