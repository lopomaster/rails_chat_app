class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  has_many :messages
  has_many :chat_rooms

  validates_presence_of :name
  validates_uniqueness_of :name
end
