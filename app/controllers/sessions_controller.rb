class SessionsController < ApplicationController
  before_action :redirect_if_authenticated, only: %i[create new]

  def create
    @user = User.authenticate_by(email: params[:user][:email].downcase, password: params[:user][:password])
    if @user
      if @user.unconfirmed?
        redirect_to new_confirmation_path, alert: 'Incorrect email or password'
      else
        after_login_path = session[:user_return_to] || root_path
        login @user
        redirect_to after_login_path, notice: 'Signed in.'
      end
    else
      flash[:alert] = 'Incorrect email or password.'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: 'Signed out.'
  end

  def new; end
end
