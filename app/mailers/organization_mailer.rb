class OrganizationMailer < ApplicationMailer
  default from: "hi@feiy.co"

  def organization_contact_email(organization, sender, body)
    @organization = organization
    @sender = sender
    @body = body
    mail(to: @organization.email, subject: "Message from feiy user")
  end

end
