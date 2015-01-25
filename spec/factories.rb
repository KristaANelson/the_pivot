FactoryGirl.define do
  factory :admin do
    full_name "Yolo Ono"
    email "admin@admin.com"
    password "password"
    display_name "Admin"
  end

  factory :user do
    full_name "John Bob Smith"
    email "john@bobo.com"
    password "test"
    display_name "John Smithy"
  end

  factory :item do
    title "pizza"
    description "some stuff"
    unit_price 500
    active true
  end

  factory :category do
    name "Drinks"
  end
end
