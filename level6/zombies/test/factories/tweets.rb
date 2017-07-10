FactoryGirl.define do
  factory :tweet do
    content "This is a zombie tweet"
    association :zombie
  end
end
