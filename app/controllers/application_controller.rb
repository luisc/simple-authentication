class ApplicationController < ActionController::Base

  helper_method :current_user
  helper_method :user_signed_in?

  private
    def authenticate_user!
      redirect_to root_path, alert: "You must be logged in" unless user_signed_in?
    end

    def current_user
      Current.user ||= authenticate_user_from_session
    end

    def authenticate_user_from_session
      User.find_by(id: session[:user_id])
    end

    def user_signed_in?
      current_user.present?
    end

    def login(user)
      Current.user = user
      reset_session
      session[:user_id] = user.id
    end

    def logout(user)
      Current.user = nil
      reset_session
    end
end
