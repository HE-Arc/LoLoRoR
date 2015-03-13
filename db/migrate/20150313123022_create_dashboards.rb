class CreateDashboards < ActiveRecord::Migration
  def change
    create_table :dashboards do |t|
      t.belongs_to :user, index: true
      t.string :name

      t.timestamps
    end
  end
end
