class Department < ActiveRecord::Base

  validates :tribehr_id, presence: true
  validates :name, presence: true, length: { maximum: 30 }
  
end
