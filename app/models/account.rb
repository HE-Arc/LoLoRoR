class Account < ActiveRecord::Base
  has_and_belongs_to_many :trackgroups, -> { uniq }
  has_and_belongs_to_many :users, -> { uniq }
  
  #TODO marche pas
  def self.search(search)
  if search
   # find(:all, :conditions => ["pseudoLoL LIKE ?", "%#{search}%"])
    #find(:all)#, :conditions => ["pseudoLoL LIKE yopyop2"])
    where(":pseudoLoL LIKE :pseudo", {:pseudoLoL => "pseudoLoL", :pseudo => "#{search}"})
  else
    find(:all)
  end
end
  
end
