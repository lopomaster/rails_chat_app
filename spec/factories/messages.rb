FactoryGirl.define do
  factory :message do
    body { Faker::Lorem.sentence }
    chat_room
    user
  end

end