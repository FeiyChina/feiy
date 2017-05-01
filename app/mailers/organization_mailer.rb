class OrganizationMailer < ApplicationMailer
  default from: "hi@feiy.co"

  def organization_contact_email(organization, sender,body)
    @organization = organization
    @sender = sender
    @body = body
    mail(to: "sebastian.nugnez@gmail.com", subject: "Message from feiy user")
  end

end
# @organization.email
