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
    password_confirmation "test"
    display_name "John Smithy"
  end

  factory :image do
    title "johnny"
    description "johnny depp"
    img File.new("#{Rails.root}/spec/support/images/heart_pizza.gif")
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
