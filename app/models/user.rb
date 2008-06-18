require 'digest/sha1'
class User < ActiveRecord::Base
  acts_as_ferret :fields => [:login ,  :email ,   :name,  :lastname ,  :organization,  :tag_list]
  acts_as_agent :activation => true

  acts_as_container

  has_one :profile
  
  has_many :participants
  has_and_belongs_to_many :events 
  has_and_belongs_to_many :machines 
  
  attr_accessible :email2, :email3, :superuser, :disabled
  
  
  
def name
  
  return self.profile.name if self.profile
end
def lastname
  
return self.profile.lastname if self.profile
end
def organization
return self.profile.organization if self.profile
end


  def self.authenticate_with_login_and_password(login, password)
    u = find_by_login(login) # need to get the salt
    unless u
      u = find_by_email(login)
      unless u
        u = find_by_email2(login)
        unless u
          u = find_by_email3(login)
        end
      end
    end
    u && u.password_authenticated?(password) ? u : nil
  end
  
   #callback that replace empty strings in email2 and email3 for NULL
   def before_save
     if self.email2==""
       self.email2 = nil
     end
     if self.email3==""
       self.email3 = nil
     end
 end
 
 #returns a javascript array of all users
 def self.print_array_of_all_users
    temp = ""
    for user in User.find(:all)
      temp = temp + "\"" + user.login + "\", "
    end
    temp.chop.chop   #removes the last character, in this case the last space and the last comma
   
 end
 
 
end
