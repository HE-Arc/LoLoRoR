class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :pseudoLoL
      t.integer :idLoL
      t.string :password

      t.timestamps
    end
  end
end
