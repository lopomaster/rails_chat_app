FactoryGirl.define do
  factory :chat_room do
    title  { generate :room_name }
  end

  UNIQUES_CHATROOM_NAMES ||= {}
  sequence :room_name do
    title = "ROOM_#{ Random.rand(1..99999).to_s }"
    title = "ROOM_#{ Random.rand(1..99999).to_s }" while UNIQUES_CHATROOM_NAMES.include? title
    UNIQUES_CHATROOM_NAMES[title] = true
    title
  end
end