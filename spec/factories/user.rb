FactoryGirl.define do
  factory :user do
    sequence(:first_name){ |n| "John #{n}" }
    sequence(:last_name){ |n| "Doe #{n}" }
    sequence(:email){ |n| "j#{n}@clio.com" }
    sequence(:title){ |n| "Master of #{n}" }
    sequence(:tribehr_id){ |n| n }
  end
end
