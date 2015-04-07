class Trackgroup < ActiveRecord::Base
  has_and_belongs_to_many :accounts, -> { uniq }
  belongs_to :user
  
  validates :name, presence: true, allow_blank: false
end
