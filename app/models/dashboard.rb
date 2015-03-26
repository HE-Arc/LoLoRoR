class Dashboard < ActiveRecord::Base
  belongs_to :user
  has_many :match_history_modules, dependent: :destroy
  has_many :top_champions_modules, dependent: :destroy
end
