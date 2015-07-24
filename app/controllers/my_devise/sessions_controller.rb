module MyDevise
  class SessionsController < Devise::SessionsController
    def destroy
      if current_user.current_location
        current_user.current_location.destroy
      end
      super
    end
  end
end
