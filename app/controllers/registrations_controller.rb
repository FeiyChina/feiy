class RegistrationsController < Devise::RegistrationsController

  def create
    super

    if resource.save
      @user = current_user

      MIXPANEL.track(@user.id, 'Created User', {
          first_name: @user.name,
          email: @user.email
      })
      MIXPANEL.people.set(@user.id, {
          first_name: @user.name,
          email: @user.email
      })

      # Mixpanel Create User Profile
      # mixpanel.track(@user.id, 'Created User', {
      #   '$first_name' => @user.first_name,
      #   '$gametag' => @user.game_tag,
      #   '$email' => @user.email,
      # })
      # mixpanel.people.set(@user.id, {
      #   '$first_name' => @user.first_name,
      #   '$gametag' => @user.game_tag,
      #   '$email' => @user.email,
      # })
    end
  end
end




  # def track_registration(resource)

  #       user = this.current_user
  #   MIXPANEL.people.set(user.id, {
  #       $first_name: user.name,
  #       $email: user.email,
  #       ip: current_sign_in_ip
  #     });


  # end

    # if @organization.save
    #   MIXPANEL.track(@organization.user_id, 'Created', {
    #     content: "Organization",
    #     name: @organization.name
    #   })

    #   redirect_to dashboard_path
    # else
    #   render :new
    # end





  # def create
  #   super
  #   track_sign_in(this.resource) if signed_in?
  #   puts this.resource.to_s
  # end

  # private
  # def track_sign_in(resource)
  #   user = this.current_user
  #   MIXPANEL.people.set(user.id, {
  #       first_name: user.name,
  #       email: user.email,
  #       ip: current_sign_in_ip
  #     });
  # end
