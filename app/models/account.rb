class Account < ActiveRecord::Base
  has_and_belongs_to_many :trackgroups
end
