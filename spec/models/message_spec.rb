require 'rails_helper'

class MessageSpec < ActiveSupport::TestCase
  include Mongoid::Document
  include Mongoid::Timestamps
end


RSpec.describe Message, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_timestamps }

  it { is_expected.to have_fields(:body) }
  it { is_expected.to have_field(:body).of_type(String) }

  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :chat_room }

  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:chat_room) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_length_of(:body).within(2..1000) }

end
