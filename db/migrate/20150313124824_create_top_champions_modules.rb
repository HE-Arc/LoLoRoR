class CreateTopChampionsModules < ActiveRecord::Migration
  def change
    create_table :top_champions_modules do |t|
      t.belongs_to :dashboard, index: true
      t.belongs_to :account, index: true
      t.integer :nb_champion
      t.integer :duration
      t.string :match_type
      
      t.timestamps
    end
  end
end
