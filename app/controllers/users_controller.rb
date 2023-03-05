class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[edit destroy update]
  before_action :redirect_if_authenticated, only: %i[create new]

  def create
    @user = User.new(create_user_params)
    if @user.save
      @user.send_confirmation_email!
      redirect_to root_path, notice: 'Please check your email for confirmation instrucations.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.destroy
    reset_session
    redirect_to root_path, notice: 'Your account has been deleted.'
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.authenticate(params[:user][:current_password])
      if @user.update(update_user_params)
        redirect_to root_path, notice: 'Account Updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    else
      flash[:error] = 'Incorrect password'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def create_user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def update_user_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
