require 'rails_helper'

class UserSpec < ActiveSupport::TestCase
  include Mongoid::Document
  include Mongoid::Timestamps
end

RSpec.describe User, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_timestamps }

  it { is_expected.to have_fields(:name) }
  it { is_expected.to have_field(:name).of_type(String) }

  it { is_expected.to have_many :messages }
  it { is_expected.to have_many :chat_rooms }

  it { is_expected.to validate_uniqueness_of(:name) }
end