class UserController < Devise::SessionsController
  def create
    super
    track_sign_in(this.resource) if signed_in?
    puts this.resource.to_s
  end

  private
  def track_sign_in(resource)
    user = this.current_user
    MIXPANEL.people.set(user.id, {
        first_name: user.name,
        email: user.email,
        ip: current_sign_in_ip
      });
  end

end
