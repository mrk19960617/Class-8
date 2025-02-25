class SessionsController < ApplicationController
  def new
    # render login form in sessions/new.html.erb
  end

  def create
    # 1. Find the user by email
    @user = User.find_by(email: params[:email])

    # 2. Check if the user exists and the password matches using BCrypt
    if @user && BCrypt::Password.new(@user["password"]) == params["password"]
      # 3. Set session to log in the user
      session[:user_id] = @user.id
      flash[:notice] = "Welcome."
      redirect_to "/companies"
    else
      flash[:alert] = "Invalid email or password."
      redirect_to "/login"
    end
  end

  def destroy
    # 4. Log out the user
    session[:user_id] = nil
    flash[:notice] = "Goodbye."
    redirect_to "/login"
  end
end
