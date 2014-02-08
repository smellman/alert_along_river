class AdminUser < ActiveRecord::Base
  # attr_accessible :title, :body
  has_secure_password
end
