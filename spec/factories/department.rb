FactoryGirl.define do
  factory :department do
    sequence(:name){ |n| "Deparment # #{n}" }
    sequence(:tribehr_id){ |n| n }
  end
end
