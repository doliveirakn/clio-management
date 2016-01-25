class Department < ActiveRecord::Base

  validates :tribehr_id, presence: true
  validates :name, presence: true, length: { max: 30 }
  
end
