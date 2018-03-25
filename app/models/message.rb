class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String
  belongs_to :user
  belongs_to :chat_room

  index({ starred: 1 })

  validates_presence_of :user
  validates_presence_of :chat_room
  validates :body, presence: true, length: {minimum: 2, maximum: 1000}

  after_create { MessagesRelayJob.perform_now(self) }


  def timestamp
    created_at.strftime('%H:%M:%S %d %B %Y')
  end

end
