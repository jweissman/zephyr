# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :star do
    x 1
    y 1
    name "MyString"
    description "MyText"
    active false
  end
end
