class User < ActiveRecord::Base

  validates :tribehr_id, presence: true
  validates :email, :title, presence: true, length: { maximum: 64 }
  validates :first_name, :last_name, presence: true, length: { maximum: 32}

  belongs_to :manager, primary_key: :tribehr_id, class_name: "User", inverse_of: :reports
  has_many :reports, primary_key: :tribehr_id, foreign_key: :manager_id, class_name: "User"
  
  
end
