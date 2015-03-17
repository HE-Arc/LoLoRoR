class Dashboard < ActiveRecord::Base
  belongs_to :user
  has_many :match_history_modules
  has_many :top_champions_modules
end
