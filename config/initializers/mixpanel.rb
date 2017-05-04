if Rails.env.production?
  MIXPANEL = Mixpanel::Tracker.new(ENV['MIXPANEL_TOKEN_PRODUCTION'])
else
  MIXPANEL = Mixpanel::Tracker.new(ENV['MIXPANEL_TOKEN_DEV']) do |type, message|
     Rails.logger.debug("Mixpanel Request: #{type}, #{message}")
  end
end
