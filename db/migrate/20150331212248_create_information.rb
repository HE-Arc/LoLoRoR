class CreateInformation < ActiveRecord::Migration
  def change
    create_table :information do |t|
      t.string :title
      t.text :smallDescription
      t.text :detailedDescription

      t.timestamps
    end
  end
end
