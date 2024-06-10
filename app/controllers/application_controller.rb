class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery unless: -> { request.format.json? }
  before_action :store_user_location!, if: :storable_location?
  before_action :configure_permitted_parameters, if: :devise_controller?
  # The callback which stores the current location must be added before you authenticate the user
  # as `authenticate_user!` (or whatever your resource is) will halt the filter chain and redirect
  # before the location can be stored.
  # before_action :authenticate_user!
  before_action :set_paper_trail_whodunnit

  # stop google indexing on staging
  # unless APPLICATION_CONFIG['crawling']
  #   http_basic_authenticate_with(
  #     name: SECRET_CONFIG['site_username'],
  #     password: SECRET_CONFIG['site_password']
  #     )
  # end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || root_path
  end

  private
  # Its important that the location is NOT stored if:
  # - The request method is not GET (non idempotent)
  # - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an
  #    infinite redirect loop.
  # - The request is an Ajax request as this can lead to very unexpected behaviour.
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end

  # def user_for_paper_trail
  #   current_admin_user.try(:id)
  # end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation])
  end
end
