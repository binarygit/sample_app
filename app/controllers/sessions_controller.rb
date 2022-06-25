class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:sessions][:email])

    if @user&.authenticate(params[:sessions][:password])
      #redirect to user show
    else
    flash.now[:danger] = 'Invalid email or password'
    render :new, status: :unprocessable_entity
    end
  end

  def destroy
  end
end
