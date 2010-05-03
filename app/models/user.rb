require 'active_support/secure_random'
require 'digest/sha1'

class User < ActiveRecord::Base
  validates_presence_of :username, :email, :role
  validates_presence_of :password, :password_confirmation, :unless => :password_exists?
  validates_confirmation_of :password
  validates_uniqueness_of :username, :email
  validates_length_of :password, :minimum => 6, :unless => :password_blank?
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_format_of :website, :with => /^$|^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/i
  
  before_validation :generate_salt, :unless => :password_blank?
  before_validation :assign_default_role, :on => :create
  after_validation :encode_password, :unless => :password_blank?
  
  attr_protected :crypted_password, :password_salt
  attr_accessor :password, :password_confirmation

  has_many :articles
  has_many :comments
  has_many :pages
  belongs_to :role
  
  is_gravtastic!
  
  def role?(role)
    self.role && self.role.name == role.to_s
  end
  
  private
  def password_exists?
    self.crypted_password && self.password_salt
  end
  
  def password_blank?
    !(self.password && self.password_confirmation && self.password != '' && self.password_confirmation != '')
  end
  
  def generate_salt
    self.password_salt = ActiveSupport::SecureRandom.base64(16)
  end
  
  def encode_password
    self.crypted_password = User.digest(self.password, self.password_salt)
    self.password, self.password_confirmation = nil
  end
  
  def assign_default_role
    self.role = Role.retrieve(:user)
  end
  
  class << self
    def digest(password, salt)
      Digest::SHA1.hexdigest("--#{salt}--#{password}--")
    end
    
    def authenticate(username, password)
      user = where(:username => username).limit(1).first
      where(:username => username, :crypted_password => digest(password || '', user ? user.password_salt : '')).limit(1).first
    end
  end
end
