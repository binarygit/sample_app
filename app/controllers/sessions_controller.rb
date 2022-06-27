class SessionsController < ApplicationController
  def new
  end

  def create
    user = user = User.find_by(email: params[:session][:email])

    if user&.authenticate(params[:session][:password])
      login user
      remember user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email or password'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_url
  end
end
