class CreateUsersTrackgroups < ActiveRecord::Migration
  def change
    create_table :users_trackgroups, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :trackgroup, index: true
    end
  end
end
