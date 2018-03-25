FactoryGirl.define do
  factory :user do
    name        { generate :username }
  end

  UNIQUES_USERNAMES ||= {}
  sequence :username do
    name = "USER_#{ Random.rand(1..99999).to_s }"
    name = "USER_#{ Random.rand(1..99999).to_s }" while UNIQUES_USERNAMES.include? name
    UNIQUES_USERNAMES[name] = true
    name
  end

end
