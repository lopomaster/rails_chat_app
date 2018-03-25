require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

  it "should set a signed cookie" do
    user = create :user
    cookies.should_receive(:signed).once.and_return(cookies)
    cookies.should_receive(:signed).once.with(:user_name, user.name)
    helper.set_cookie(:user_name, user.name)
  end
end