FactoryGirl.define do
  factory :company do
    name { Faker::Company.name }
    created_at '2017-03-15 21:05:32'
    updated_at '2017-03-15 21:05:32'
  end
end
