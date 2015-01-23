FactoryGirl.define do
  factory :user do
    full_name "John Bob Smith"
    email "john@bobo.com"
    password "test"
    display_name "John Smithy"
  end

  factory :item do
    title "pizza"
    description "some stuff"
    unit_price "500"
  end

  factory :category do
    name "Drinks"
  end
end
