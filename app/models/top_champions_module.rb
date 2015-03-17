class TopChampionsModule < ActiveRecord::Base
  belongs_to :dashboard
  belongs_to :account
end
