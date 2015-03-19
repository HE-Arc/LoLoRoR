class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login
  attr_accessor :login
  
  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["username = :value OR email = :value", { :value => login.downcase }]).first
      else
        where(conditions.to_h).first
      end
    end
  
  validates :username,
  :presence => true,
  :uniqueness => {
    :case_sensitive => false
  } 
  
  has_many :trackgroups, dependent: :destroy
  has_many :dashboards, dependent: :destroy
  has_and_belongs_to_many :accounts, -> { uniq }
  
end
