class SessionsController < ApplicationController

  def new
  end

  def create
    if user = User.authenticate_by(session_params)
      login user
      redirect_to root_path, notice: "Signed in"
    else
      flash[:alert] = "Couldn't log you in"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout current_user
    redirect_to root_path, notice: 'Logged out'
  end

  private
    def session_params
      params.require(:session).permit(:email, :password)
    end

end
