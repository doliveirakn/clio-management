class User < ActiveRecord::Base

  validates :tribehr_id, presence: true
  validates :email, presence: true, length: { max: 64 }
  validates :first_name, :last_name, :title, presence: true, length: { max: 32}
  
end
