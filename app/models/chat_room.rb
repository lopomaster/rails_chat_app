class ChatRoom
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String

  has_many :messages
  has_many :users

  validates_presence_of :title
  validates_uniqueness_of :title

end
