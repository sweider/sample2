FactoryGirl.define do
  factory :user do
    name     "Misha"
    email    "sample@example.com"
    login    "sweider_b"
    password "q1w2e3r4t5"
    password_confirmation "q1w2e3r4t5"

    factory :admin do
      admin "true"
    end
  end


  factory :micropost do
    content  " Lorem ispum"
    user
  end
end