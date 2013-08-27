FactoryGirl.define do
  factory :user do
    name     "Misha"
    email    "sample@example.com"
    password "q1w2e3r4t5"
    password_confirmation "q1w2e3r4t5"
  end
end