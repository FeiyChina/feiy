class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pundit
  include ActionView::Helpers::UrlHelper
  after_filter :store_location

  after_action :verify_authorized, except: [:index, :show,
                                            :new, :create, :search,
                                            :edit, :organization_contact,
                                            :organization_send, :like,
                                            :update, :by_tag],  unless: :skip_pundit?
  after_action :verify_policy_scoped, only: [], unless: :skip_pundit?


  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  protected

  def authenticate_user!(options={})
    if user_signed_in?
      super(options)
    else
      redirect_to new_user_registration_path unless %w(passwords registrations sessions).include? controller_name
    end
  end

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :avatar, :city, :name])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :avatar, :city, :name])
  end


  def store_location
    # store last url as long as it isn't a /users path
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  end


  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
