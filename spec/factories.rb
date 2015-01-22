FactoryGirl.define do
  factory :user do
    full_name "John Bob Smith"
    email "john@bobo.com"
    password_digest nil
    display_name "John Smithy"
    password "test"
  end
end
