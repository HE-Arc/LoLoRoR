class Account < ActiveRecord::Base
  has_and_belongs_to_many :trackgroups, -> { uniq }
  has_and_belongs_to_many :users, -> { uniq }
  
end
