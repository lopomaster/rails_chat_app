require 'rails_helper'

class ChatRoomSpec < ActiveSupport::TestCase
  include Mongoid::Document
  include Mongoid::Timestamps
end

RSpec.describe ChatRoom, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_timestamps }

  it { is_expected.to have_fields(:title) }
  it { is_expected.to have_field(:title).of_type(String) }

  it { is_expected.to have_many :messages }
  it { is_expected.to have_many :users }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_uniqueness_of(:title) }

end
