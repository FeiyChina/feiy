class RegistrationsController < Devise::RegistrationsController

  def create
    super

    if resource.persisted?
      @user = current_user
      track_registration(resource)
    end
  end


  private

  def track_registration(resource)

    user = resource
    MIXPANEL.people.set(
      user.id,
      {
          "$first_name" => user.name,
          "$email" => user.email,
          "city" => user.city
      }
    )
  end

  protected

  def after_sign_up_path_for(resource)
    thank_you_path
  end
end
