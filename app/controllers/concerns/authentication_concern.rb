module AuthenticationConcern
  extend ActiveSupport::Concern

  included do
    before_action :current_user
    helper_method :current_user, :user_signed_in?
  end

  def authenticate_user!
    store_request_location # to redirect after login
    redirect_to login_path, alert: 'You need to login to access that page.' unless user_signed_in?
  end

  def login(user)
    reset_session
    session[:current_user_id] = user.id
  end

  def logout
    reset_session
  end

  def redirect_if_authenticated
    redirect_to root_path, alert: 'You are already logged in.' if user_signed_in?
  end

  private

  def current_user
    Current.user ||= session[:current_user_id] && User.find_by(id: session[:current_user_id])
  end

  def user_signed_in?
    Current.user.present?
  end

  # The store_request_location method stores the request.original_url in the session so it can be retrieved later.
  # We only do this if the request made was a get request. We also call request.local? to ensure it was a local request.
  # This prevents redirecting to an external application. We need to do this before visiting the login page otherwise
  # the call to request.original_url will always return the url to the login page.
  def store_request_location
    session[:user_return_to] = request.original_url if request.get? && request.local?
  end
end
