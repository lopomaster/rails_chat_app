module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', @current_user.name
    end

    protected

    def find_verified_user # this checks if user exit
      if verified_user = User.find_by(name: cookies.signed[:user_name])
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end