Shoulda::Matchers.configure do |sm|
  sm.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
