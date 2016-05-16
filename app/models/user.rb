class User < ActiveRecord::Base
    #attr_accessor :password
    #attr_accessor :password, :password_confirmation
    
    validates_presence_of :name, :email , :password, :password_confirmation, :username 
    validates_length_of :name, maximum: 32
    
    validates_uniqueness_of :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
    
    validates :password, confirmation: true
    validates_length_of :password, :in => 6..20
    
#  validates :name, :presence => true, :uniqueness => true
#  validates :email, :presence => true, :uniqueness => true
    
#  require 'bcrypt'
   require 'digest/sha1'  
  
    before_save :encrypt_password
    after_save :clear_password
    
#  def encrypt_password
#    if password.present?
#      self.salt = BCrypt::Engine.generate_salt
#      self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
#    end
#  end
  
  def encrypt_password
    if password.present?
      self.password = Digest::SHA1.hexdigest(password)
    end
  end  
    
  
  def clear_password
    self.password = nil
  end
  
  def self.authenticate(username_or_email="", login_password="")
  if  format.match(name_or_email)    
    user = User.find_by_email(username_or_email)
  else
    user = User.find_by_username(username_or_email)
  end
  if user && user.match_password(login_password)
    return user
  else
    return false
  end
  end  
  
def match_password(login_password="")
  encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
end

end
